import { Injectable, Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { PrismaClient } from '@prisma/client';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';

@Injectable()
class PrismaService extends PrismaClient {}

@Module({
  imports: [JwtModule.register({}), PassportModule],
  providers: [AuthService, PrismaService],
  controllers: [AuthController],
})
export class AuthModule {}
