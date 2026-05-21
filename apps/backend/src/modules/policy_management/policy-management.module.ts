import { AppConstants } from '../../common/constants/app.constants';
import { PrismaService } from '../../prisma/prisma.service';
import { PolicyManagementController } from './policy-management.controller';
import { PolicyManagementService } from './policy-management.service';
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [PolicyManagementController],
  providers: [PolicyManagementService, PrismaService, AppConstants],
  exports: [],
})
export class PolicyManagementModule {}
