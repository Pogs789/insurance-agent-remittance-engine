import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Post,
  Query,
} from '@nestjs/common';
import { MonthlyRemittanceService } from './monthly_remittance.service';
import { CreateMonthlyRemittanceDto } from './dto/create-monthly_remittance.dto';

@Controller('monthly-remittance')
export class MonthlyRemittanceController {
  constructor(private monthlyRemittanceService: MonthlyRemittanceService) {}

  @HttpCode(HttpStatus.OK)
  @Post('calculate')
  createNewInsuranceRemittanceRecord(
    @Body() createMonthlyRemittance: CreateMonthlyRemittanceDto,
  ) {
    const { userId, planholderData } = createMonthlyRemittance;
    return this.monthlyRemittanceService.calculateRemittanceAmount(
      planholderData,
      userId,
    );
  }

  @HttpCode(HttpStatus.OK)
  @Post('get-history')
  getAllRemittanceRecords(@Query('userId') userId: string) {
    return this.monthlyRemittanceService.getAllRemittanceHistory(userId);
  }

  @HttpCode(HttpStatus.OK)
  @Post('update-calculation')
  updateInsuranceRemittanceRecord(
    @Body() updateMonthlyRemittance: CreateMonthlyRemittanceDto,
  ) {
    const { userId, planholderData } = updateMonthlyRemittance;
    return this.monthlyRemittanceService.calculateRemittanceAmount(
      planholderData,
      userId,
    );
  }
}
