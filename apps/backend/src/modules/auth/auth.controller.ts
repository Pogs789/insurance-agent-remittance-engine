import {
  Body,
  Controller,
  Post,
  HttpCode,
  HttpStatus,
  Query,
  Render,
  Get,
  UseGuards,
  Request,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LogOutDto } from './dto/login.dto';
import { RefreshTokenDto } from './dto/refresh-token.dto';
import { AgentRegisterDto } from './dto/register.dto';
import { LocalAuthGuard } from './passport/local-auth.guard';
import { Public } from '../../common/decorators/public.decorator';

type AuthenticatedUser = {
  id: string;
  email: string;
  role: string;
  createdAt: Date;
  updatedAt: Date;
};

// added
type RequestWithUser = Request & {
  user: AuthenticatedUser;
};

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  // POST auth/login
  @Public()
  @HttpCode(HttpStatus.OK)
  @Post('login')
  @UseGuards(LocalAuthGuard)
  signIn(@Request() req: { user: RequestWithUser['user'] }) {
    return this.authService.login(req.user);
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

  //TODO: Relocate this to agent module
  @Public()
  @HttpCode(HttpStatus.OK)
  @Post('agent-register')
  register(@Body() registerDto: AgentRegisterDto) {
    const {
      firstName,
      middleName,
      lastName,
      insuranceCompanyId,
      birthDate,
      email,
      password,
    } = registerDto;

    return this.authService.agentRegister(
      firstName,
      middleName,
      lastName,
      insuranceCompanyId,
      birthDate,
      email,
      password,
    );
  }

  @Public()
  @HttpCode(HttpStatus.OK)
  @Get('verify-token')
  @Render('email_confirmation')
  verifyNewUserToken(@Query('verificationToken') verificationToken: string) {
    return this.authService.verifyEmailToken(verificationToken);
  }
}
