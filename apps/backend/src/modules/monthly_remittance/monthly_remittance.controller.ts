import { Body, Controller, HttpCode, HttpStatus, Post } from '@nestjs/common';
import { MonthlyRemittanceService } from './monthly_remittance.service';

@Controller('monthly-remittance')
export class MonthlyRemittanceController {
  constructor(private monthlyRemittanceService: MonthlyRemittanceService) {}

  @HttpCode(HttpStatus.OK)
  @Post('create')
  createNewInsuranceRemittanceRecord(
    @Body() createMonthlyRemittance: Record<string, any>,
  ) {
    //FIXME: Create and Update DTO to accurately match whatevers the input from the mobile app.
    return this.monthlyRemittanceService.calculateRemittanceAmount(
      createMonthlyRemittance.planholderData,
      createMonthlyRemittance.userId,
    );
  }
}
