import { IsEmail, IsString, IsUUID, MinLength } from 'class-validator';

export class SignInDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(8)
  password!: string;
}

export class LogOutDto {
  @IsUUID()
  userId!: string;

  @IsString()
  @MinLength(64)
  refreshToken!: string;
}
