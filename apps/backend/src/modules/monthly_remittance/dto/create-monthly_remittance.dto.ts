import {
  IsArray,
  IsNumber,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';
import { PlanholderDataDto } from './planholder_data.dto';
import { Type } from 'class-transformer';

export class CreateMonthlyRemittanceDto {
  @IsOptional()
  @IsString()
  userId?: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => PlanholderDataDto)
  planholderData!: PlanholderDataDto[];

  @IsNumber()
  commissionRate!: number;
}
