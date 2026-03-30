import { Module } from '@nestjs/common';
import { MonthlyRemittanceService } from './monthly_remittance.service';
import { MonthlyRemittanceController } from './monthly_remittance.controller';
import { PrismaService } from '../../prisma/prisma.service';
import { AppConstants } from '../../common/constants/app.constants';

@Module({
  providers: [MonthlyRemittanceService, PrismaService, AppConstants],
  controllers: [MonthlyRemittanceController],
})
export class MonthlyRemittanceModule {}
