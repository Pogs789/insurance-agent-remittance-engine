import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AgentsModule } from './modules/agents/agents.module';
import { AuthModule } from './modules/auth/auth.module';
import { MailModule } from './modules/mail/mail.module';
import { MonthlyRemittanceModule } from './modules/monthly_remittance/monthly_remittance.module';
import { PolicyManagementModule } from './modules/policy_management/policy-management.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [
    PolicyManagementModule,
    MailModule,
    AuthModule,
    PrismaModule,
    MonthlyRemittanceModule,
    AgentsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
