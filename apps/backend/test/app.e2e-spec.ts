import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { AppModule } from './../src/app.module';
import { PrismaService } from './../src/prisma/prisma.service';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    process.env.JWT_ACCESS_SECRET ??= 'test-jwt-access-secret';

    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    })
      .overrideProvider(PrismaService)
      .useValue({
        $connect: jest.fn(),
        $disconnect: jest.fn(),
      })
      .compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  afterAll(async () => {
    if (app) {
      await app.close();
    }
  });

  //TODO: Create e2e tests for all features that were built.
  describe('POST /monthly-remittance', () => {
    it('should create new insurance remittance record', async () => {
      const httpServer = app.getHttpServer() as Parameters<typeof request>[0];

      const createMonthlyRemittanceDto = {
        planholderData: [{ paymentPeriodAmount: 1000 }],
        commissionRate: 10,
      };

      const response = await request(httpServer)
        .post('/monthly-remittance')
        .send(createMonthlyRemittanceDto)
        .expect(200);

      expect(response.body).toHaveProperty('amountToBeRemitted');
    });
  });

  // describe('POST /monthly-remittance/calculate', () => {
  //   it('should create new insurance remittance record', async () => {
  //     const createMonthlyRemittanceDto = {
  //       planholderData: [
  //         {
  //           paymentPeriodAmount: 1000,
  //         },
  //       ],
  //       commissionRate: 10,
  //     };

  //     const response = await request(app.getHttpServer())
  //       .post('/monthly-remittance/calculate')
  //       .send(createMonthlyRemittanceDto)
  //       .expect(200);

  //     expect(response.body).toHaveProperty('amountToBeRemitted');
  //     expect(response.body.amountToBeRemitted).toBeDefined();
  //   });
  // });

  // describe('POST /monthly-remittance/get-history', () => {
  //   it('should get all remittance records for a user', async () => {
  //     const userId = 'test-user-id';

  //     const response = await request(app.getHttpServer())
  //       .post('/monthly-remittance/get-history')
  //       .query({ userId })
  //       .expect(200);

  //     expect(Array.isArray(response.body)).toBe(true);
  //   });
  // });

  // describe('POST /monthly-remittance/update-calculation', () => {
  //   it('should update insurance remittance record', async () => {
  //     const updateMonthlyRemittance = {
  //       userId: 'test-user-id',
  //       id: 'test-record-id',
  //       planholderData: [
  //         {
  //           paymentPeriodAmount: 2000,
  //         },
  //       ],
  //     };

  //     const response = await request(app.getHttpServer())
  //       .post('/monthly-remittance/update-calculation')
  //       .send(updateMonthlyRemittance)
  //       .expect(200);

  //     expect(response.body).toHaveProperty('amountToBeRemitted');
  //     expect(response.body.amountToBeRemitted).toBeDefined();
  //   });
  // });
});
