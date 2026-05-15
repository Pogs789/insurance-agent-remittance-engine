import { PolicyManagementController } from './policy-management.controller';
import { PolicyManagementService } from './policy-management.service';
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [PolicyManagementController],
  providers: [PolicyManagementService],
  exports: [],
})
export class PolicyManagementModule {}
