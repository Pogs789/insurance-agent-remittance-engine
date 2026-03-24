import { IsDate, IsEmail, IsInt, IsString, MinLength } from 'class-validator';

export class UserRegisterDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(8)
  password!: string;

  @IsString()
  agentName!: string;
  insuranceCompany!: string;
  branchAddress!: string;

  @IsInt()
  commissionRate!: number; //Ill put here commission rate because I have no idea on how much the commission rate does an insurance company sets to an insurance agent.

  @IsDate()
  birthDate!: Date;
}
