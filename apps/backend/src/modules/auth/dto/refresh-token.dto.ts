import { IsString, MinLength, IsUUID } from 'class-validator';

export class RefreshTokenDto {
  @IsUUID()
  userId!: string;
  @IsString()
  @MinLength(64)
  refreshToken!: string;
}
