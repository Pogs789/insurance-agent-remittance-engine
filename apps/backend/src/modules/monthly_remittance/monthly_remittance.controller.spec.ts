import { Test, TestingModule } from '@nestjs/testing';
import { MonthlyRemittanceController } from './monthly_remittance.controller';
import { MonthlyRemittanceService } from './monthly_remittance.service';

describe('MonthlyRemittanceController', () => {
  let controller: MonthlyRemittanceController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MonthlyRemittanceController],
      providers: [
        {
          provide: MonthlyRemittanceService,
          useValue: {
            createNewInsuranceRemittanceRecord: jest.fn(),
          },
        },
      ],
    }).compile();

    controller = module.get<MonthlyRemittanceController>(
      MonthlyRemittanceController,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
