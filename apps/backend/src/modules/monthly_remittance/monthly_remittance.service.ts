import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { PlanholderDataDto } from './dto/planholder_data.dto';
import { Prisma } from '../../generated/client';
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
        const netTakeHome =
          grossCommission * (1 - this.appConstants.valueAddedTax);
        return sum + (p.paymentPeriodAmount - netTakeHome);
      }, 0),
    );

    if (!userId) return { amountToBeRemitted: amountToBeRemitted };
    const insuranceAgent = await this.prisma.insuranceAgent.findFirst({
      where: { id: userId },
    });

    if (!insuranceAgent) return { amountToBeRemitted: amountToBeRemitted };

    await this.prisma.$transaction([
      this.prisma.monthlyRemittanceHistory.create({
        data: {
          agentId: insuranceAgent.id,
          amountRemitted: amountToBeRemitted,
        },
      }),
    ]);

    return { amountToBeRemitted: amountToBeRemitted };
  }

  /**
   * Gets all Monthly Remittance History made by an insurance agent.
   * @param userId
   * @returns remittanceDetails | null
   */
  async getAllRemittanceHistory(userId: string) {
    const insuranceAgent = await this.prisma.insuranceAgent.findFirst({
      where: { id: userId },
    });

    if (!insuranceAgent) {
      throw new NotFoundException('Insurance Agent Not Found.');
    }

    const remittanceDetails =
      await this.prisma.monthlyRemittanceHistory.findMany({
        where: {
          agentId: insuranceAgent.id,
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
    const insuranceCompany = await this.prisma.insuranceCompany.findFirst({
      where: { id: userId },
    });

    if (!insuranceCompany) {
      throw new NotFoundException('Insurance Company Not Found.');
    }

    const amountToBeRemitted = planholders.reduce((sum, p) => {
      const rate = new Decimal(insuranceCompany.commissionRate).div(100);
      const payment = new Decimal(p.paymentPeriodAmount);

      const grossCommission = payment.mul(rate);
      const netTakeHome = grossCommission.mul(this.appConstants.valueAddedTax);
      return sum.plus(payment.minus(netTakeHome));
    }, new Decimal(0));

    await this.prisma.monthlyRemittanceHistory.update({
      where: {
        id: id,
        agentId: userId,
      },
      data: {
        amountRemitted: amountToBeRemitted,
      },
    });

    return { amountToBeRemitted: amountToBeRemitted };
  }
}
