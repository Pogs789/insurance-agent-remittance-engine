import {
  Body,
  Controller,
  Post,
  HttpCode,
  HttpStatus,
  Put,
  Query,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto, LogOutDto } from './dto/login.dto';
import { RefreshTokenDto } from './dto/refresh-token.dto';
import { AgentRegisterDto } from './dto/register.dto';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  // POST auth/login
  @HttpCode(HttpStatus.OK)
  @Post('login')
  signIn(@Body() signInDto: SignInDto) {
    return this.authService.signIn(signInDto.email, signInDto.password);
  }

  // POST auth/logout
  @HttpCode(HttpStatus.OK)
  @Post('logout')
  logout(@Body() logOutDto: LogOutDto) {
    return this.authService.logout(logOutDto.userId, logOutDto.refreshToken);
  }

  // POST auth/refresh-token
  @HttpCode(HttpStatus.OK)
  @Post('refresh-token')
  refreshToken(@Body() refreshTokenDto: RefreshTokenDto) {
    return this.authService.refresh(
      refreshTokenDto.userId,
      refreshTokenDto.refreshToken,
    );
  }

  @HttpCode(HttpStatus.OK)
  @Post('agent-register')
  register(@Body() registerDto: AgentRegisterDto) {
    const {
      firstName,
      middleName,
      lastName,
      insuranceCompany,
      birthDate,
      branchAddress,
      commissionRate,
      email,
      password,
    } = registerDto;

    return this.authService.agentRegister(
      firstName,
      middleName,
      lastName,
      insuranceCompany,
      birthDate,
      branchAddress,
      commissionRate,
      email,
      password,
    );
  }

  @HttpCode(HttpStatus.OK)
  @Put('verify-token')
  verifyNewUserToken(@Query('verificationToken') verificationToken: string) {
    return this.authService.verifyEmailToken(verificationToken);
  }
}
