import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

interface PlanholderData {
  planholderName: string;
  insuranceProduct: string;
  insuranceAmount: DoubleRange;
  paymentPeriod: PaymentPeriod;
  PaymentPeriodAmount: DoubleRange;
  planholderStatus: PlanholderStatus;
}

enum PlanholderStatus {
  ACTIVE,
  INACTIVE,
  PASTDUE,
}

enum PaymentPeriod {
  MONTHLY,
  QUARTERLY,
  SEMIANNUALLY,
  ANNUALLY,
}

@Injectable()
export class MonthlyRemittanceService {
  constructor(private prisma: PrismaService) {}
  /**
   * Calculate the total remittance needed based on the percentage set by the insurance company to an agent.
   */
  async calculateRemittanceAmount(planholders: JSON, userId: string) {
    
  }
}
