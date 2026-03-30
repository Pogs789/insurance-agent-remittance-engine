import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { PlanholderDataDto } from './dto/planholder_data.dto';
import { Prisma } from '@prisma/client';
import { AppConstants } from '../../common/constants/app.constants';
import { Decimal } from '@prisma/client/runtime/client';

@Injectable()
export class MonthlyRemittanceService {
  constructor(
    private prisma: PrismaService,
    private appConstants: AppConstants,
  ) {}
  /**
   * Calculate the total remittance needed based on the percentage set by the insurance company to an agent.
   */
  async calculateRemittanceAmount(
    planholders: PlanholderDataDto[],
    commissionRate: number,
    userId?: string,
  ): Promise<{ amountToBeRemitted: Decimal }> {
    const amountToBeRemitted = new Decimal(
      planholders.reduce((sum, p) => {
        const rate = commissionRate / 100;
        const grossCommission = p.paymentPeriodAmount * rate;
        const netTakeHome = grossCommission * this.appConstants.valueAddedTax;
        return sum + (p.paymentPeriodAmount - netTakeHome);
      }, 0),
    );

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

    await this.prisma.$transaction([
      this.prisma.monthlyRemittanceHistory.create({
        data: {
          userId: userId,
          amountRemitted: amountToBeRemitted,
          planholderData: planholderDataForDb,
        },
      }),
    ]);

    return { amountToBeRemitted: amountToBeRemitted };
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

  //TODO: Update calculation logic.
  async updateRemittanceAmount(
    planholders: PlanholderDataDto[],
    userId: string,
    id: string,
  ): Promise<{ amountToBeRemitted: Decimal }> {
    const insuranceAgent = await this.prisma.user.findFirst({
      where: { id: userId },
    });

    if (!insuranceAgent) {
      throw new NotFoundException('Insurance Agent Not Found.');
    }

    const amountToBeRemitted = new Decimal(
      planholders.reduce((sum, p) => {
        const rate = insuranceAgent.commissionRate / 100;
        const grossCommission = p.paymentPeriodAmount * rate;
        const netTakeHome = grossCommission * this.appConstants.valueAddedTax;
        return sum + (p.paymentPeriodAmount - netTakeHome);
      }, 0),
    );

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
        amountRemitted: amountToBeRemitted,
        planholderData: planholderDataForDb,
      },
    });

    return { amountToBeRemitted: amountToBeRemitted };
  }
}
