import { Test, TestingModule } from '@nestjs/testing';
import { MonthlyRemittanceService } from './monthly_remittance.service';
import { PrismaService } from '../../prisma/prisma.service';

describe('MonthlyRemittanceService', () => {
  let service: MonthlyRemittanceService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MonthlyRemittanceService,
        {
          provide: PrismaService,
          useValue: {},
        },
      ],
    }).compile();

    service = module.get<MonthlyRemittanceService>(MonthlyRemittanceService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
