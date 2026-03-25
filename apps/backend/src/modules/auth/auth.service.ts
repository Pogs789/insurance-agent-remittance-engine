import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import bcrypt from 'bcrypt';
import { randomUUID } from 'crypto';
@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async agentRegister(
    firstName: string,
    middleName: string,
    lastName: string,
    insuranceCompany: string,
    birthDate: Date,
    branchAddress: string,
    commissionRate: number,
    email: string,
    password: string,
  ) {
    //TODO: Implement User Registration with email verification.
    return await this.prisma.user.create({
      data: {
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        insuranceCompany: insuranceCompany,
        branchAddress: branchAddress,
        birthDate: birthDate,
        commissionRate: commissionRate,
        email: email,
        passwordHash: password,
      },
    });
  }

  async signIn(email: string, pass: string): Promise<any> {
    const user = await this.prisma.user.findUnique({ where: { email } });

    if (!user)
      throw new UnauthorizedException(
        'Sorry. Your email does not exist. Please Try Again',
      );

    const verify = await bcrypt.compare(pass, user.passwordHash);

    if (!verify)
      throw new UnauthorizedException(
        'Your Password is incorrect. Please Try Again',
      );

    const tokens = await this.issueTokens(user.id, user.email, user.role);

    await this.storeRefreshToken(user.id, tokens.refreshToken);

    return {
      ...tokens,
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      },
    };
  }

  async refresh(userId: string, refreshToken: string) {
    const activeTokens = await this.prisma.refreshToken.findMany({
      where: { userId, revokedAt: null, expiresAt: { gt: new Date() } },
      orderBy: { createdAt: 'desc' },
      take: 5,
    });

    let matchedTokenId: string | null = null;

    for (const rt of activeTokens) {
      if (await bcrypt.compare(refreshToken, rt.tokenHash)) {
        matchedTokenId = rt.id;
        break;
      }
    }

    if (!matchedTokenId)
      throw new UnauthorizedException(
        'This refresh token is invalid. Please login again.',
      );

    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user)
      throw new UnauthorizedException(
        'Sorry. This user does not exist. Please login again.',
      );

    const tokens = await this.issueTokens(user.id, user.email, user.role);

    await this.prisma.$transaction([
      this.prisma.refreshToken.update({
        where: { id: matchedTokenId },
        data: { revokedAt: new Date() },
      }),
      this.prisma.refreshToken.create({
        data: {
          id: randomUUID(),
          userId,
          tokenHash: await bcrypt.hash(tokens.refreshToken, 12),
          expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
        },
      }),
    ]);

    return tokens;
  }

  async logout(userId: string, refreshToken: string) {
    const tokens = await this.prisma.refreshToken.findMany({
      where: { userId, revokedAt: null },
    });

    for (const rt of tokens) {
      if (await bcrypt.compare(refreshToken, rt.tokenHash)) {
        await this.prisma.refreshToken.update({
          where: { id: rt.id },
          data: { revokedAt: new Date() },
        });
        break;
      }
    }

    return { success: true };
  }

  /**
   * This is only accessible to only this class. These two functions manage all user tokens when accessing the mobile app via API.
   */

  private async issueTokens(userId: string, email: string, role: string) {
    const payload = { sub: userId, email, role };

    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(payload, {
        secret: process.env.JWT_ACCESS_SECRET,
        expiresIn: '15m',
      }),
      this.jwtService.signAsync(payload, {
        secret: process.env.JWT_REFRESH_SECRET,
        expiresIn: '7d',
      }),
    ]);

    return { accessToken, refreshToken };
  }

  private async storeRefreshToken(userId: string, refreshToken: string) {
    await this.prisma.refreshToken.create({
      data: {
        userId,
        tokenHash: await bcrypt.hash(refreshToken, 12),
        expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      },
    });
  }
}
