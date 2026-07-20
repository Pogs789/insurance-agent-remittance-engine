import 'dotenv/config';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../generated/client';

if (!process.env.DATABASE_URL) {
  throw new Error('DATABASE_URL environment variable is not set');
}

const connectionString = `${process.env.DATABASE_URL}`;
const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('Generated data from seed...');
  const existingCompanies = await prisma.insuranceCompany.count();
  if (existingCompanies === 0) {
    const insuranceCompanySample = await prisma.insuranceCompany.createMany({
      data: [
        {
          companyName: 'St. Peter Life Plan Inc.',
          productsOffered: 'Funeral Package',
          commissionRate: 40.0,
        },
        {
          companyName: 'Kaiser Insurance Co.',
          productsOffered: 'Healthcare Insurance',
          commissionRate: 30.0,
        },
      ],
    });

    console.log(insuranceCompanySample);
  }

  const existingProducts = await prisma.insuranceProduct.count();
  console.log('Number of Existing Insurance Products: ', existingProducts);

  if (existingProducts === 0) {
    const insuranceProductSample = await prisma.insuranceProduct.createMany({
      data: [
        {
          insuranceCompanyId: '558c025a-0377-4853-af8a-c21734a406cb',
          insuranceProductName: 'St. John',
          productContents:
            'Metal Casket, double top (split and full lid covers), full glass, elegant interiors, corners and handles',
          productAmount: 300000,
        },
        {
          insuranceCompanyId: '558c025a-0377-4853-af8a-c21734a406cb',
          insuranceProductName: 'St. Paul',
          productContents:
            'Wood Casket, sealer type (split lid cover), full glass, elegant interiors, corners and handles',
          productAmount: 160000,
        },
        {
          insuranceCompanyId: '558c025a-0377-4853-af8a-c21734a406cb',
          insuranceProductName: 'St. Ferdinand',
          productContents:
            'Metal Casket, single top (split lid cover), full glass, elegant interiors, corners and handles',
          productAmount: 105000,
        },
        {
          insuranceCompanyId: '558c025a-0377-4853-af8a-c21734a406cb',
          insuranceProductName: 'St. Francis',
          productContents:
            'Wood Casket, single top (split lid cover), full glass, elegant interiors, corners and handles',
          productAmount: 100000,
        },
      ],
    });

    console.log(insuranceProductSample);
  }
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
