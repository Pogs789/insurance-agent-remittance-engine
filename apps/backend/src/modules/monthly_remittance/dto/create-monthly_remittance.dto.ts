import {
  IsArray,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  Max,
  Min,
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
  @IsNotEmpty()
  planholderData!: PlanholderDataDto[];

  //Address the possible edge case where the user accidentally inputs -20 or 200.
  @IsNumber()
  @Min(0)
  @Max(100)
  commissionRate!: number;
}
