import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { CreatePolicyManagementDto } from './dto/create-policy-management.dto';
import { UpdatePolicyManagementDto } from './dto/update-policy-management.dto';
import { PolicyManagementService } from './policy-management.service';

//TODO: Create a Basic CRUD Feature which only the Admin, which is basically the Insurance Company that will use this app, can access it, while the insurance agent can only view it.
//TODO: If we are done with the "Happy Path", proceed to writing unit tests to identify possible edge cases.
@Controller('policy-managements')
export class PolicyManagementController {
  constructor(
    private readonly policyManagementService: PolicyManagementService,
  ) {}

  @Post()
  create(@Body() createPolicyManagementDto: CreatePolicyManagementDto) {
    return this.policyManagementService.create(createPolicyManagementDto);
  }

  @Get()
  findAll() {
    return this.policyManagementService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.policyManagementService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updatePolicyManagementDto: UpdatePolicyManagementDto,
  ) {
    return this.policyManagementService.update(+id, updatePolicyManagementDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.policyManagementService.remove(+id);
  }
}
