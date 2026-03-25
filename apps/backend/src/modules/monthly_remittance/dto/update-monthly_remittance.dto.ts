import { IsArray, IsString, IsUUID, ValidateNested } from 'class-validator';
import type { UUID } from 'crypto';
import { PlanholderDataDto } from './planholder_data.dto';
import { Type } from 'class-transformer';

export class UpdateMonthlyRemittanceDto {
  @IsString()
  @IsUUID()
  userId!: UUID;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => PlanholderDataDto)
  planholderData!: PlanholderDataDto[];
}
