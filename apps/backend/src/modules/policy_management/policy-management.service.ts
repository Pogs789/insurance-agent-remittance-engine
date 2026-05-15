import { Injectable } from '@nestjs/common';
import { CreatePolicyManagementDto } from './dto/create-policy-management.dto';
import { UpdatePolicyManagementDto } from './dto/update-policy-management.dto';

@Injectable()
export class PolicyManagementService {
  //TODO: Create a Basic CRUD Feature which only the Admin, which is basically the Insurance Company that will use this app, can access it, while the insurance agent can only view it.
  //TODO: If we are done with the "Happy Path", proceed to writing unit tests to identify possible edge cases.
  create(createPolicyManagementDto: CreatePolicyManagementDto) {
    return 'This action adds a new policy-management';
  }

  findAll() {
    return `This action returns all policy-managements`;
  }

  findOne(id: number) {
    return `This action returns a #id policy-management`;
  }

  update(id: number, updatePolicyManagementDto: UpdatePolicyManagementDto) {
    return `This action updates a #id policy-management`;
  }

  remove(id: number) {
    return `This action removes a #id policy-management`;
  }
}
