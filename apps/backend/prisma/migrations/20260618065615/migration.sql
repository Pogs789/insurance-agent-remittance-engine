/*
  Warnings:

  - The `role` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[verificationToken]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `birthDate` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstName` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `middleName` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('AGENT', 'COMPANYADMIN', 'SUPERADMIN');

-- CreateEnum
CREATE TYPE "PlanholderStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "birthDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "emailConfirmedAt" TIMESTAMP(3),
ADD COLUMN     "firstName" TEXT NOT NULL,
ADD COLUMN     "lastName" TEXT NOT NULL,
ADD COLUMN     "middleName" TEXT NOT NULL,
ADD COLUMN     "verificationToken" TEXT,
ADD COLUMN     "verificationTokenExpiresAt" TIMESTAMP(3),
DROP COLUMN "role",
ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'AGENT';

-- CreateTable
CREATE TABLE "InsuranceAgent" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "insuranceCompanyId" TEXT NOT NULL,

    CONSTRAINT "InsuranceAgent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MonthlyRemittanceHistory" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "amountRemitted" DECIMAL(10,2) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "MonthlyRemittanceHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlanholderData" (
    "id" TEXT NOT NULL,
    "monthlyRemittanceId" TEXT NOT NULL,
    "planholderName" TEXT NOT NULL,
    "insuranceProductId" TEXT NOT NULL,
    "currentStatus" "PlanholderStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "PlanholderData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InsuranceProduct" (
    "id" TEXT NOT NULL,
    "insuranceCompanyId" TEXT NOT NULL,
    "insuranceProductName" TEXT NOT NULL,
    "productContents" TEXT NOT NULL,
    "productAmount" DECIMAL(10,2) NOT NULL,
    "paymentTerms" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "InsuranceProduct_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InsuranceCompany" (
    "id" TEXT NOT NULL,
    "companyName" TEXT NOT NULL,
    "productsOffered" TEXT NOT NULL,
    "commissionRate" DECIMAL(10,2) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "InsuranceCompany_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserFeedback" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "feedbackTitle" TEXT NOT NULL,
    "feedbackDescription" TEXT NOT NULL,
    "recommendToOtherAgents" BOOLEAN NOT NULL,

    CONSTRAINT "UserFeedback_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "InsuranceAgent_userId_key" ON "InsuranceAgent"("userId");

-- CreateIndex
CREATE INDEX "InsuranceAgent_userId_idx" ON "InsuranceAgent"("userId");

-- CreateIndex
CREATE INDEX "MonthlyRemittanceHistory_agentId_idx" ON "MonthlyRemittanceHistory"("agentId");

-- CreateIndex
CREATE INDEX "UserFeedback_userId_idx" ON "UserFeedback"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "User_verificationToken_key" ON "User"("verificationToken");

-- AddForeignKey
ALTER TABLE "InsuranceAgent" ADD CONSTRAINT "InsuranceAgent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MonthlyRemittanceHistory" ADD CONSTRAINT "MonthlyRemittanceHistory_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "InsuranceAgent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlanholderData" ADD CONSTRAINT "PlanholderData_monthlyRemittanceId_fkey" FOREIGN KEY ("monthlyRemittanceId") REFERENCES "MonthlyRemittanceHistory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlanholderData" ADD CONSTRAINT "PlanholderData_insuranceProductId_fkey" FOREIGN KEY ("insuranceProductId") REFERENCES "InsuranceProduct"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InsuranceProduct" ADD CONSTRAINT "InsuranceProduct_insuranceCompanyId_fkey" FOREIGN KEY ("insuranceCompanyId") REFERENCES "InsuranceCompany"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFeedback" ADD CONSTRAINT "UserFeedback_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
