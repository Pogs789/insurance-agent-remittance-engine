import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { PrismaModule } from '../../prisma/prisma.module';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { MailService } from '../mail/mail.service';

@Module({
  imports: [JwtModule.register({}), PassportModule, PrismaModule],
  providers: [AuthService, MailService],
  controllers: [AuthController],
})
export class AuthModule {}
