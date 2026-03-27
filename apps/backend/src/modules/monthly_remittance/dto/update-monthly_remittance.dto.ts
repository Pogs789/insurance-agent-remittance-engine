import { IsArray, IsString, ValidateNested } from 'class-validator';
import { PlanholderDataDto } from './planholder_data.dto';
import { Type } from 'class-transformer';

export class UpdateMonthlyRemittanceDto {
  @IsString()
  userId!: string;

  @IsString()
  id!: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => PlanholderDataDto)
  planholderData!: PlanholderDataDto[];
}
