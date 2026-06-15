import { IsNumber, IsString } from 'class-validator';

export class CreateNewCompanyDto {
  @IsString()
  companyName!: string;

  @IsString()
  branchAddress!: string;

  @IsString()
  productsOffered!: string;

  @IsNumber()
  commissionRate!: string;
}
