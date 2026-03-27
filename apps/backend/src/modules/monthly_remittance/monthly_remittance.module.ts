import { Module } from '@nestjs/common';
import { MonthlyRemittanceService } from './monthly_remittance.service';
import { MonthlyRemittanceController } from './monthly_remittance.controller';
import { PrismaService } from 'src/prisma/prisma.service';

@Module({
  providers: [MonthlyRemittanceService, PrismaService],
  controllers: [MonthlyRemittanceController],
})
export class MonthlyRemittanceModule {}
