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

  it('should calculate and store remittance correctly', async () => {
    const mockUser = {
      id: 'user-1',
      commissionRate: 20,
    };

    const planholders = [
      { paymentPeriodAmount: 1000 },
      { paymentPeriodAmount: 2000 },
    ];

    const prismaMock = {
      user: {
        findFirst: jest.fn().mockResolvedValue(mockUser),
      },
      monthlyRemittanceHistory: {
        create: jest.fn().mockResolvedValue({}),
      },
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MonthlyRemittanceService,
        {
          provide: PrismaService,
          useValue: prismaMock,
        },
      ],
    }).compile();

    const service = module.get<MonthlyRemittanceService>(
      MonthlyRemittanceService,
    );

    const result = await service.calculateRemittanceAmount(
      planholders as any,
      30,
      'user-1',
    );

    // 3000 * (100 - 20)% = 2400
    expect(result).toBe(2100);

    expect(prismaMock.user.findFirst).toHaveBeenCalledWith({
      where: { id: 'user-1' },
    });

    expect(prismaMock.monthlyRemittanceHistory.create).toHaveBeenCalled();
  });
});
