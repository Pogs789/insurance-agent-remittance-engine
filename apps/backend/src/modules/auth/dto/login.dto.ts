import { IsEmail, IsString, MinLength } from 'class-validator';
import { UUID } from 'crypto';

export class SignInDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(8)
  password!: string;
}

export class LogOutDto {
  userId!: UUID;

  @IsString()
  @MinLength(64)
  refreshToken!: string;
}
