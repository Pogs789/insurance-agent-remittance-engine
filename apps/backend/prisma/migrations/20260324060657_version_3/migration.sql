/*
  Warnings:

  - The `role` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "RemittanceStatus" AS ENUM ('PENDING', 'REMITTED', 'VALIDATING', 'CLEARED', 'REJECTED');

-- AlterTable
ALTER TABLE "MonthlyRemittanceHistory" ADD COLUMN     "isRemitted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "remittanceStatus" "RemittanceStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "User" DROP COLUMN "role",
ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'AGENT';
