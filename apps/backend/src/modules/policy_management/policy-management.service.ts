import { Injectable } from '@nestjs/common';
import { CreatePolicyManagementDto } from './dto/create-policy-management.dto';
import { UpdatePolicyManagementDto } from './dto/update-policy-management.dto';
import { PrismaService } from '../../prisma/prisma.service';

@Injectable()
export class PolicyManagementService {
  constructor(private readonly prisma: PrismaService) {}

  async create(dto: CreatePolicyManagementDto, insuranceCompanyId: string) {
    const { paymentTerms, ...productData } = dto;

    return this.prisma.insuranceProduct.create({
      data: {
        ...productData,
        insuranceCompanyId,
        paymentTerms: {
          create: paymentTerms.map((term) => ({
            period: term.period,
            amount: term.amount,
          })),
        },
      },
      include: { paymentTerms: true },
    });
  }

  async findAll(insuranceCompanyId: string) {
    return this.prisma.insuranceProduct.findMany({
      where: { insuranceCompanyId },
      include: { paymentTerms: true },
    });
  }

  async findOne(id: string) {
    return this.prisma.insuranceProduct.findUniqueOrThrow({
      where: { id },
      include: { paymentTerms: true },
    });
  }

  async update(id: string, dto: UpdatePolicyManagementDto) {
    const { paymentTerms, ...productData } = dto;

    return this.prisma.insuranceProduct.update({
      where: { id },
      data: {
        ...productData,
        paymentTerms: {
          deleteMany: {},
          create: paymentTerms.map((term) => ({
            period: term.period,
            amount: term.amount,
          })),
        },
      },
      include: { paymentTerms: true },
    });
  }

  async remove(id: string) {
    await this.prisma.insuranceProduct.delete({ where: { id } });
    return 'Insurance Product Successfully deleted.';
  }
}
