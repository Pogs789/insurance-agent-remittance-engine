import { Body, Controller, Post, HttpCode, HttpStatus } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto, LogOutDto } from './dto/login.dto';
import { RefreshTokenDto } from './dto/refresh-token.dto';

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

  // PATCH auth/refresh-token
  @HttpCode(HttpStatus.OK)
  @Post('refresh-token')
  refreshToken(@Body() refreshTokenDto: RefreshTokenDto) {
    return this.authService.refresh(
      refreshTokenDto.userId,
      refreshTokenDto.refreshToken,
    );
  }
}
