import { IsEnum, IsNumber, IsOptional, IsString } from 'class-validator';

export enum PlanholderStatus {
  ACTIVE = 'ACTIVE',
  INACTIVE = 'INACTIVE',
  PASTDUE = 'PASTDUE',
}

export enum PaymentPeriod {
  MONTHLY = 'MONTHLY',
  QUARTERLY = 'QUARTERLY',
  SEMIANNUALLY = 'SEMIANNUALLY',
  ANNUALLY = 'ANNUALLY',
  SPOTON = 'SPOTON',
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
