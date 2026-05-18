import { Type } from 'class-transformer';
import { IsDate, IsEmail, IsString, MinLength } from 'class-validator';

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
  insuranceCompanyId!: string;

  @IsDate()
  @Type(() => Date)
  birthDate!: Date;
}
