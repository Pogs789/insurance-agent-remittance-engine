import { IsEmail, IsString, MinLength } from 'class-validator';
import { UUID } from 'crypto';

//TODO: Update the variables here to reflect insurance policy.
export class UpdatePolicyManagementDto {
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
