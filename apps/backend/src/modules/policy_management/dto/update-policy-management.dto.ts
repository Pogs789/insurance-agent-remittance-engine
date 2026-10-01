import {
  IsArray,
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsString,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { PaymentPeriod } from '../../../generated/client';

class PaymentTermDto {
  @IsEnum(PaymentPeriod)
  period!: PaymentPeriod;

  @Type(() => Number)
  @IsNumber()
  amount!: number;
}

export class UpdatePolicyManagementDto {
  @IsString()
  @IsNotEmpty()
  insuranceProductName!: string;

  @IsString()
  @IsNotEmpty()
  productContents!: string;

  @Type(() => Number)
  @IsNumber()
  productAmount!: number;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => PaymentTermDto)
  paymentTerms!: PaymentTermDto[];
}
