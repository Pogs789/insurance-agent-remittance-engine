import { IsString, MinLength, IsUUID } from 'class-validator';
import type { UUID } from 'crypto';

export class CreateMonthlyRemittanceDto {
  @IsString()
  userId!: UUID;
  
}