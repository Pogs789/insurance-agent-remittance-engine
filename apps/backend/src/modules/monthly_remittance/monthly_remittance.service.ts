import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { PlanholderDataDto } from './dto/planholder_data.dto';
import { Prisma } from '@prisma/client';

@Injectable()
export class MonthlyRemittanceService {
  constructor(private prisma: PrismaService) {}
  /**
   * Calculate the total remittance needed based on the percentage set by the insurance company to an agent.
   */
  async calculateRemittanceAmount(
    planholders: PlanholderDataDto[],
    userId: string,
  ) {
    const insuranceAgent = await this.prisma.user.findFirst({
      where: { id: userId },
    });

    if (!insuranceAgent) {
      throw new NotFoundException('Insurance Agent Not Found.');
    }

    const totalPaymentPeriodAmount = planholders.reduce(
      (sum, p) => sum + p.paymentPeriodAmount,
      0,
    );

    const amountRemitted =
      totalPaymentPeriodAmount * ((100 - insuranceAgent.commissionRate) * 0.01);

    const planholderDataForDb: Prisma.JsonArray = planholders.map((p) => ({
      planholderName: p.planholderName,
      insuranceProduct: p.insuranceProduct,
      insuranceAmount: p.insuranceAmount,
      paymentPeriod: p.paymentPeriod,
      paymentPeriodAmount: p.paymentPeriodAmount,
      planholderStatus: p.planholderStatus,
    })) as Prisma.JsonArray;

    await this.prisma.monthlyRemittanceHistory.create({
      data: {
        userId: userId,
        amountRemitted: amountRemitted,
        planholderData: planholderDataForDb,
      },
    });

    return amountRemitted;
  }
}
