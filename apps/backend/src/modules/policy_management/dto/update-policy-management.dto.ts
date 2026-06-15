import { IsArray, IsNotEmpty, IsNumber, IsString } from 'class-validator';

//TODO: Update the variables here to reflect insurance policy.
export class UpdatePolicyManagementDto {
  @IsString()
  @IsNotEmpty()
  insuranceProductName!: string;

  @IsString()
  @IsNotEmpty()
  productContents!: string;

  @IsNumber()
  productAmount!: string;

  @IsArray()
  paymentTerms!: string[];
}
