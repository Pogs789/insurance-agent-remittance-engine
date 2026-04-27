import { JwtStrategy } from './jwt_stategy/jwt.strategy';
import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { PrismaModule } from '../../prisma/prisma.module';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { MailService } from '../mail/mail.service';
import { AppConstants } from '../../common/constants/app.constants';
import { ConfigService } from '@nestjs/config';

@Module({
  imports: [JwtModule.register({}), PassportModule, PrismaModule],
  providers: [
    JwtStrategy,
    AuthService,
    MailService,
    AppConstants,
    ConfigService,
  ],
  controllers: [AuthController],
})
export class AuthModule {}
