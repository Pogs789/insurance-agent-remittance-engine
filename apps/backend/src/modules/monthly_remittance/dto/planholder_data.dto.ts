import { IsEnum, IsNumber, IsOptional, IsString } from 'class-validator';

export enum PlanholderStatus {
  ACTIVE = 'Active',
  INACTIVE = 'Inactive',
  PASTDUE = 'Past Due',
}

export enum PaymentPeriod {
  MONTHLY = 'Monthly',
  QUARTERLY = 'Quarterly',
  SEMIANNUALLY = 'Semi-Annually',
  ANNUALLY = 'Annually',
  SPOTON = 'Spot-On',
}

export class PlanholderDataDto {
  @IsString()
  planholderName!: string;

  @IsOptional()
  @IsString()
  insuranceProduct!: string;

  @IsOptional()
  @IsNumber()
  insuranceAmount!: number;

  @IsOptional()
  @IsEnum(PaymentPeriod)
  paymentPeriod!: PaymentPeriod;

  @IsNumber()
  paymentPeriodAmount!: number;

  @IsEnum(PlanholderStatus)
  planholderStatus!: PlanholderStatus;
}
