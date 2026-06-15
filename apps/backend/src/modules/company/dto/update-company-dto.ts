import { IsDecimal, IsString } from 'class-validator';

export class UpdateExistingCompanyDto {
  @IsString()
  companyName!: string;

  @IsString()
  branchAddress!: string;

  @IsString()
  productsOffered!: string;

  @IsDecimal()
  commissionRate!: string;
}
