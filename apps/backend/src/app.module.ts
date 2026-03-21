import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './modules/auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { MonthlyRemittanceModule } from './modules/monthly_remittance/monthly_remittance.module';

@Module({
  imports: [AuthModule, PrismaModule, MonthlyRemittanceModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
