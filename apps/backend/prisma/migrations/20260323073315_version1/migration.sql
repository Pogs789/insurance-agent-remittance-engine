-- CreateEnum
CREATE TYPE "role" AS ENUM ('AGENT', 'ADMIN');

-- CreateTable
CREATE TABLE "MonthlyRemittanceHistory" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "amountRemitted" DOUBLE PRECISION NOT NULL,
    "commissionRate" DOUBLE PRECISION NOT NULL,
    "planholderData" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "MonthlyRemittanceHistory_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "MonthlyRemittanceHistory" ADD CONSTRAINT "MonthlyRemittanceHistory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
