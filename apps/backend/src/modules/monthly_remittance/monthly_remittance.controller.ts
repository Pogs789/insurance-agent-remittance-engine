import { Body, Controller, HttpCode, HttpStatus, Post } from '@nestjs/common';
import { MonthlyRemittanceService } from './monthly_remittance.service';
import { CreateMonthlyRemittanceDto } from './dto/create-monthly_remittance.dto';

@Controller('monthly-remittance')
export class MonthlyRemittanceController {
  constructor(private monthlyRemittanceService: MonthlyRemittanceService) {}

  @HttpCode(HttpStatus.OK)
  @Post('create')
  createNewInsuranceRemittanceRecord(
    @Body() createMonthlyRemittance: CreateMonthlyRemittanceDto,
  ) {
    const { userId, planholderData } = createMonthlyRemittance;
    return this.monthlyRemittanceService.calculateRemittanceAmount(
      planholderData,
      userId,
    );
  }
}
