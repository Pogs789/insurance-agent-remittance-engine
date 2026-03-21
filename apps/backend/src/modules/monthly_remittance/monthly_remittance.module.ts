import { Module } from '@nestjs/common';
import { MonthlyRemittanceService } from './monthly_remittance.service';
import { MonthlyRemittanceController } from './monthly_remittance.controller';

@Module({
  providers: [MonthlyRemittanceService],
  controllers: [MonthlyRemittanceController],
})
export class MonthlyRemittanceModule {}
