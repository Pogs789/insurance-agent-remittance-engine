import { Injectable, NotFoundException } from '@nestjs/common';
import { CreatePolicyManagementDto } from './dto/create-policy-management.dto';
import { UpdatePolicyManagementDto } from './dto/update-policy-management.dto';
import { PrismaService } from '../../prisma/prisma.service';
import { AppConstants } from '../../common/constants/app.constants';

@Injectable()
export class PolicyManagementService {
  constructor(
    private prisma: PrismaService,
    private appConstants: AppConstants,
  ) {}
  //TODO: Create a Basic CRUD Feature which only the Admin, which is basically the Insurance Company that will use this app, can access it, while the insurance agent can only view it.
  //TODO: If we are done with the "Happy Path", proceed to writing unit tests to identify possible edge cases.
  create(createPolicyManagementDto: CreatePolicyManagementDto) {
    return 'This action adds a new policy-management';
  }

  async findAll(insuranceCompanyId: string) {
    const insuranceProducts = await this.prisma.insuranceProduct.findMany({
      where: {
        insuranceCompanyId: insuranceCompanyId,
      },
    });

    if (!insuranceProducts) return null;

    return insuranceProducts;
  }

  async findOne(id: string) {
    const insuranceProduct =
      await this.prisma.insuranceProduct.findFirstOrThrow({
        where: {
          id: id,
        },
      });

    if (!insuranceProduct)
      throw new NotFoundException(
        'Insurance details cannot be retrieved. Please Try Again.',
      );

    return insuranceProduct;
  }

  update(id: number, updatePolicyManagementDto: UpdatePolicyManagementDto) {
    return `This action updates a #id policy-management`;
  }

  remove(id: number) {
    return `This action removes a #id policy-management`;
  }
}
