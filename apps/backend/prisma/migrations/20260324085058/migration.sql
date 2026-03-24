/*
  Warnings:

  - You are about to drop the column `commissionRate` on the `MonthlyRemittanceHistory` table. All the data in the column will be lost.
  - Added the required column `commissionRate` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "MonthlyRemittanceHistory" DROP COLUMN "commissionRate";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "commissionRate" DOUBLE PRECISION NOT NULL;
