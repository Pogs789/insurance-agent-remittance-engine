import { Type } from 'class-transformer';
import { IsDate, IsEmail, IsInt, IsString, MinLength } from 'class-validator';

export class AgentRegisterDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(8)
  password!: string;

  @IsString()
  firstName!: string;

  @IsString()
  middleName!: string;

  @IsString()
  lastName!: string;

  @IsString()
  insuranceCompany!: string;

  @IsString()
  branchAddress!: string;

  @IsInt()
  commissionRate!: number; //Ill put here commission rate because I have no idea on how much the commission rate does an insurance company sets to an insurance agent.

  @IsDate()
  @Type(() => Date)
  birthDate!: Date;
}
