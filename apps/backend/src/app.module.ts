import { MailModule } from './modules/mail/mail.module';
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './modules/auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { MonthlyRemittanceModule } from './modules/monthly_remittance/monthly_remittance.module';
import { AgentsModule } from './modules/agents/agents.module';

@Module({
  imports: [
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
