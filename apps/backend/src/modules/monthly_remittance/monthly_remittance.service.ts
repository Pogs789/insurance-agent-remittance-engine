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
    commissionRate: number,
    userId?: string,
  ): Promise<any> {
    let amountToBeRemitted: number = 0.0;
    const totalPaymentPeriodAmount = planholders.reduce(
      (sum, p) => sum + p.paymentPeriodAmount,
      0,
    );

    amountToBeRemitted =
      totalPaymentPeriodAmount * ((100 - commissionRate) * 0.01);

    if (!userId) return { amountToBeRemitted: amountToBeRemitted };
    const insuranceAgent = await this.prisma.user.findFirst({
      where: { id: userId },
    });

    if (!insuranceAgent) return { amountToBeRemitted: amountToBeRemitted };

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
        amountRemitted: amountToBeRemitted,
        planholderData: planholderDataForDb,
      },
    });

    return { amountToBeRemitted: amountToBeRemitted };
  }

  /**
   * Gets all Monthly Remittance History made by an insurance agent.
   * @param userId
   * @returns remittanceDetails | null
   */
  async getAllRemittanceHistory(userId: string) {
    const insuranceAgent = await this.prisma.user.findFirst({
      where: { id: userId },
    });

    if (!insuranceAgent) {
      throw new NotFoundException('Insurance Agent Not Found.');
    }

    const remittanceDetails =
      await this.prisma.monthlyRemittanceHistory.findMany({
        where: {
          userId: userId,
        },
      });

    if (remittanceDetails === null) return null;
    else return remittanceDetails;
  }

  async updateRemittanceAmount(
    planholders: PlanholderDataDto[],
    userId: string,
    id: string,
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

    await this.prisma.monthlyRemittanceHistory.update({
      where: {
        id: id,
        userId: userId,
      },
      data: {
        amountRemitted: amountRemitted,
        planholderData: planholderDataForDb,
      },
    });

    return amountRemitted;
  }
}
