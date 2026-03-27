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

  /**
   * This is a public API which any insurance agent can calculate their total remittance needed based on their commission rate set by the insurance company.
   * @param createMonthlyRemittanceDto
   * @returns remittanceAmount
   */
  @HttpCode(HttpStatus.OK)
  @Post('calculate')
  createNewInsuranceRemittanceRecord(
    @Body() createMonthlyRemittanceDto: CreateMonthlyRemittanceDto,
  ) {
    const { userId, planholderData, commissionRate } =
      createMonthlyRemittanceDto;
    return this.monthlyRemittanceService.calculateRemittanceAmount(
      planholderData,
      commissionRate,
      userId,
    );
  }

  @HttpCode(HttpStatus.OK)
  @Post('get-history')
  getAllRemittanceRecords(@Query('userId') userId: string) {
    return this.monthlyRemittanceService.getAllRemittanceHistory(userId);
  }

  //TODO: This route must be protected.
  @HttpCode(HttpStatus.OK)
  @Post('update-calculation')
  updateInsuranceRemittanceRecord(
    @Body() updateMonthlyRemittance: CreateMonthlyRemittanceDto,
  ) {
    const { userId, planholderData, commissionRate } = updateMonthlyRemittance;
    return this.monthlyRemittanceService.calculateRemittanceAmount(
      planholderData,
      commissionRate,
      userId,
    );
  }
}
