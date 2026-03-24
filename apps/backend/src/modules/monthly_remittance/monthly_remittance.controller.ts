import { Body, Controller, HttpCode, HttpStatus, Post, Query } from '@nestjs/common';
import { MonthlyRemittanceService } from './monthly_remittance.service';
import { CreateMonthlyRemittanceDto } from './dto/create-monthly_remittance.dto';
import type { UUID } from 'crypto';

@Controller('monthly-remittance')
export class MonthlyRemittanceController {
  constructor(private monthlyRemittanceService: MonthlyRemittanceService) {}

  @HttpCode(HttpStatus.OK)
  @Post('create')
  createNewInsuranceRemittanceRecord(
    @Body() createMonthlyRemittance: CreateMonthlyRemittanceDto,
  ) {
    return this.monthlyRemittanceService.calculateRemittanceAmount(
      createMonthlyRemittance.planholderData,
      createMonthlyRemittance.userId,
    );
  }

  @HttpCode(HttpStatus.OK)
  @Post('update')
  updateInsuranceRemittanceRecord(
    @Query() userId: UUID,
    @Body() updateMonthlyRemittanceDto: CreateMonthlyRemittanceDto,
  ) {}
}
