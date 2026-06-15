import { Test, TestingModule } from '@nestjs/testing';
import { CompanyService } from './company.service';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateNewCompanyDto } from './dto/create-company.dto';
import { UpdateExistingCompanyDto } from './dto/update-company-dto';

describe('CompanyService', () => {
  let service: CompanyService;

  type PrismaServiceMock = {
    insuranceCompany: {
      create: jest.Mock;
      findMany: jest.Mock;
      findUnique: jest.Mock;
      update: jest.Mock;
      delete: jest.Mock;
    };
  };

  let prisma: PrismaServiceMock;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        CompanyService,
        {
          provide: PrismaService,
          useValue: {
            insuranceCompany: {
              create: jest.fn(),
              findMany: jest.fn(),
              findUnique: jest.fn(),
              update: jest.fn(),
              delete: jest.fn(),
            },
          },
        },
      ],
    }).compile();

    service = module.get<CompanyService>(CompanyService);
    prisma = module.get<PrismaServiceMock>(PrismaService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('create', () => {
    it('should create a company', async () => {
      const createCompanyDto: CreateNewCompanyDto = {
        companyName: 'Insular Life Inc.',
        branchAddress: 'Rizal St., Legazpi City, Albay',
        productsOffered: 'Health and Life Insurance',
        commissionRate: '20.0',
      };
      const result = { id: '1', ...createCompanyDto };
      jest.spyOn(prisma.insuranceCompany, 'create').mockResolvedValue(result);

      expect(await service.create(createCompanyDto)).toEqual(result);
      expect(prisma.insuranceCompany.create).toHaveBeenCalledWith({
        data: createCompanyDto,
      });
    });
  });

  describe('findAll', () => {
    it('should return all companies', async () => {
      const result = [{ id: '1', name: 'Test Company' }];
      jest
        .spyOn(prisma.insuranceCompany, 'findMany')
        .mockResolvedValue(result as any);

      expect(await service.findAll()).toEqual(result);
      expect(prisma.insuranceCompany.findMany).toHaveBeenCalled();
    });
  });

  describe('findOne', () => {
    it('should return a single company', async () => {
      const id = '1';
      const result = { id, name: 'Test Company' };
      jest
        .spyOn(prisma.insuranceCompany, 'findUnique')
        .mockResolvedValue(result as any);

      expect(await service.findOne(id)).toEqual(result);
      expect(prisma.insuranceCompany.findUnique).toHaveBeenCalledWith({
        where: { id },
      });
    });
  });

  describe('update', () => {
    it('should update a company', async () => {
      const id = '123';
      const updateCompanyDto: UpdateExistingCompanyDto = {
        companyName: 'Insular Life Inc.',
        branchAddress: 'Rizal St., Legazpi City, Albay',
        productsOffered: 'Health and Life Insurance',
        commissionRate: '20.0',
      };
      const result = { id, ...updateCompanyDto };
      jest
        .spyOn(prisma.insuranceCompany, 'update')
        .mockResolvedValue(result as any);

      expect(await service.update(id, updateCompanyDto)).toEqual(result);
      expect(prisma.insuranceCompany.update).toHaveBeenCalledWith({
        where: { id },
        data: updateCompanyDto,
      });
    });
  });

  describe('remove', () => {
    it('should delete a company', async () => {
      const id = '1';
      const result = { id, name: 'Test Company' };
      jest
        .spyOn(prisma.insuranceCompany, 'delete')
        .mockResolvedValue(result as any);

      expect(await service.remove(id)).toEqual(result);
      expect(prisma.insuranceCompany.delete).toHaveBeenCalledWith({
        where: { id },
      });
    });
  });
});
