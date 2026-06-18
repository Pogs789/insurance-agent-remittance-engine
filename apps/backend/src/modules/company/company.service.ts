import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateNewCompanyDto } from './dto/create-company.dto';
import { UpdateExistingCompanyDto } from './dto/update-company-dto';

@Injectable()
export class CompanyService {
  constructor(private prisma: PrismaService) {}

  async create(createCompanyDto: CreateNewCompanyDto) {
    return await this.prisma.insuranceCompany.create({
      data: createCompanyDto,
    });
  }

  async findAll() {
    return await this.prisma.insuranceCompany.findMany({
      select: {
        id: true,
        companyName: true,
        commissionRate: true,
      },
    });
  }

  async findOne(id: string) {
    return await this.prisma.insuranceCompany.findUnique({
      where: { id },
    });
  }

  async update(id: string, updateCompanyDto: UpdateExistingCompanyDto) {
    return await this.prisma.insuranceCompany.update({
      where: { id },
      data: updateCompanyDto,
    });
  }

  async remove(id: string) {
    return await this.prisma.insuranceCompany.delete({
      where: { id },
    });
  }
}
