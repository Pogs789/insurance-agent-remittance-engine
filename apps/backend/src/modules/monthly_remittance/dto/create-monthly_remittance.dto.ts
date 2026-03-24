import { IsString, IsUUID, IsJSON } from 'class-validator';
import type { UUID } from 'crypto';

export class CreateMonthlyRemittanceDto {
  @IsString()
  @IsUUID()
  userId!: UUID;

  @IsJSON()
  planholderData!: JSON;
}
