import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AgentsModule } from './modules/agents/agents.module';
import { AuthModule } from './modules/auth/auth.module';
import { MailModule } from './modules/mail/mail.module';
import { MonthlyRemittanceModule } from './modules/monthly_remittance/monthly_remittance.module';
import { PolicyManagementModule } from './modules/policy_management/policy-management.module';
import { PrismaModule } from './prisma/prisma.module';
import { APP_GUARD } from '@nestjs/core';
import { JwtAuthGuard } from './modules/auth/passport/jwt.guard';
import { CompanyModule } from './modules/company/company.module';

@Module({
  imports: [
    PolicyManagementModule,
    MailModule,
    AuthModule,
    PrismaModule,
    MonthlyRemittanceModule,
    AgentsModule,
    CompanyModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
  ],
})
export class AppModule {}
