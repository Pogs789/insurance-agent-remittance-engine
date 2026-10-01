import 'dotenv/config';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PaymentPeriod, PrismaClient } from '../generated/client';

if (!process.env.DATABASE_URL) {
  throw new Error('DATABASE_URL environment variable is not set');
}

const connectionString = `${process.env.DATABASE_URL}`;
const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  const companyId = '558c025a-0377-4853-af8a-c21734a406cb';

  await prisma.insuranceCompany.upsert({
    where: { id: companyId },
    update: {
      companyName: 'St. Peter Life Plan Inc.',
      productsOffered: 'Funeral Package',
      commissionRate: 40.0,
    },
    create: {
      id: companyId,
      companyName: 'St. Peter Life Plan Inc.',
      productsOffered: 'Funeral Package',
      commissionRate: 40.0,
    },
  });

  const products = [
    {
      id: '47da9ca5-d4f1-408a-9850-345a9ece2fef',
      insuranceProductName: 'St. Francis',
      productContents:
        'Wood Casket, single top (split lid cover), full glass, elegant interiors, corners and handles',
      productAmount: 100000,
    },
    {
      id: '7a3d5962-c067-4d3a-82bc-5001c4c8d756',
      insuranceProductName: 'St. Ferdinand',
      productContents:
        'Metal Casket, single top (split lid cover), full glass, elegant interiors, corners and handles',
      productAmount: 105000,
    },
    {
      id: '93c7b84c-93f6-4fe1-baf7-23671cc799bf',
      insuranceProductName: 'St. Paul',
      productContents:
        'Wood Casket, sealer type (split lid cover), full glass, elegant interiors, corners and handles',
      productAmount: 160000,
    },
    {
      id: '9471dbfd-b7de-4910-8523-b3d924f43149',
      insuranceProductName: 'St. John',
      productContents:
        'Metal Casket, double top (split and full lid covers), full glass, elegant interiors, corners and handles',
      productAmount: 300000,
    },
  ];

  for (const product of products) {
    await prisma.insuranceProduct.upsert({
      where: { id: product.id },
      update: {
        insuranceCompanyId: companyId,
        insuranceProductName: product.insuranceProductName,
        productContents: product.productContents,
        productAmount: product.productAmount,
      },
      create: {
        ...product,
        insuranceCompanyId: companyId,
      },
    });
  }

  const paymentTerms = [
    {
      insuranceProductId: '9471dbfd-b7de-4910-8523-b3d924f43149',
      terms: [
        { period: PaymentPeriod.ANNUALLY, amount: 60000 },
        { period: PaymentPeriod.SEMI_ANNUALLY, amount: 31800 },
        { period: PaymentPeriod.QUARTERLY, amount: 16500 },
        { period: PaymentPeriod.MONTH, amount: 5700 },
      ],
    },
    {
      insuranceProductId: '93c7b84c-93f6-4fe1-baf7-23671cc799bf',
      terms: [
        { period: PaymentPeriod.ANNUALLY, amount: 32000 },
        { period: PaymentPeriod.SEMI_ANNUALLY, amount: 16960 },
        { period: PaymentPeriod.QUARTERLY, amount: 8800 },
        { period: PaymentPeriod.MONTH, amount: 3040 },
      ],
    },
  ];

  for (const product of paymentTerms) {
    for (const term of product.terms) {
      await prisma.insurancePaymentTerm.upsert({
        where: {
          insuranceProductId_period: {
            insuranceProductId: product.insuranceProductId,
            period: term.period,
          },
        },
        update: { amount: term.amount },
        create: {
          insuranceProductId: product.insuranceProductId,
          period: term.period,
          amount: term.amount,
        },
      });
    }
  }

  console.log('Insurance company, products, and payment terms seeded.');
}

main()
  .then(async () => {
    await prisma.$disconnect();
    await pool.end();
  })
  .catch(async (error) => {
    console.error(error);
    await prisma.$disconnect();
    await pool.end();
    process.exit(1);
  });
