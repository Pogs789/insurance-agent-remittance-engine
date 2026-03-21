import { Test, TestingModule } from '@nestjs/testing';
import { MonthlyRemittanceController } from './monthly_remittance.controller';

describe('MonthlyRemittanceController', () => {
  let controller: MonthlyRemittanceController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MonthlyRemittanceController],
    }).compile();

    controller = module.get<MonthlyRemittanceController>(MonthlyRemittanceController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
