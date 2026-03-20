import { IsString, MinLength } from 'class-validator';
import { UUID } from 'crypto';

export class RefreshTokenDto {
  userId!: UUID;
  @IsString()
  @MinLength(64)
  refreshToken!: string;
}
