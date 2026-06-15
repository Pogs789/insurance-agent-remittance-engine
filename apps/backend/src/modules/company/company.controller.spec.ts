import { Test, TestingModule } from '@nestjs/testing';
import { CompanyController } from './company.controller';
import { CompanyService } from './company.service';
import { CreateNewCompanyDto } from './dto/create-company.dto';
import { UpdateExistingCompanyDto } from './dto/update-company-dto';

describe('CompanyController', () => {
  let controller: CompanyController;

  type CompanyServiceMock = {
    create: jest.Mock;
    findAll: jest.Mock;
    findOne: jest.Mock;
    update: jest.Mock;
    remove: jest.Mock;
  };

  let service: CompanyServiceMock;

  beforeEach(async () => {
    const serviceMock: CompanyServiceMock = {
      create: jest.fn(),
      findAll: jest.fn(),
      findOne: jest.fn(),
      update: jest.fn(),
      remove: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [CompanyController],
      providers: [
        {
          provide: CompanyService,
          useValue: serviceMock,
        },
      ],
    }).compile();

    controller = module.get<CompanyController>(CompanyController);
    service = module.get<CompanyServiceMock>(CompanyService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('create', () => {
    it('should call service.create with provided dto', async () => {
      const createDto: CreateNewCompanyDto = {
        companyName: 'Insular Life Inc.',
        branchAddress: 'Rizal St., Legazpi City, Albay',
        productsOffered: 'Health and Life Insurance',
        commissionRate: '20.0',
      };
      await controller.create(createDto);
      expect(service.create).toHaveBeenCalledWith(createDto);
    });
  });

  describe('findAll', () => {
    it('should call service.findAll', async () => {
      await controller.findAll();
      expect(service.findAll).toHaveBeenCalled();
    });
  });

  describe('findOne', () => {
    it('should call service.findOne with id', async () => {
      const id = '123';
      await controller.findOne(id);
      expect(service.findOne).toHaveBeenCalledWith(id);
    });
  });

  describe('update', () => {
    it('should call service.update with id and dto', async () => {
      const id = '123';
      const updateDto: UpdateExistingCompanyDto = {
        companyName: 'Insular Life Inc.',
        branchAddress: 'Rizal St., Legazpi City, Albay',
        productsOffered: 'Health and Life Insurance',
        commissionRate: '20.0',
      };
      await controller.update(id, updateDto);
      expect(service.update).toHaveBeenCalledWith(id, updateDto);
    });
  });

  describe('remove', () => {
    it('should call service.remove with id', async () => {
      const id = '123';
      await controller.remove(id);
      expect(service.remove).toHaveBeenCalledWith(id);
    });
  });
});
