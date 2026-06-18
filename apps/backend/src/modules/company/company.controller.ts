import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { CreateNewCompanyDto } from './dto/create-company.dto';
import { UpdateExistingCompanyDto } from './dto/update-company-dto';
import { CompanyService } from './company.service';
import { Public } from '../../common/decorators/public.decorator';

@Controller('company')
export class CompanyController {
  constructor(private companyService: CompanyService) {}

  @HttpCode(HttpStatus.CREATED)
  @Post()
  create(@Body() createNewCompanyDto: CreateNewCompanyDto) {
    return this.companyService.create(createNewCompanyDto);
  }

  //This is to get all company names which for the insurance agent to be able to select.
  @Public()
  @Get('public')
  findAll() {
    return this.companyService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.companyService.findOne(id);
  }

  @HttpCode(HttpStatus.OK)
  @Put(':id')
  update(
    @Param('id') id: string,
    @Body() updateCompanyDto: UpdateExistingCompanyDto,
  ) {
    return this.companyService.update(id, updateCompanyDto);
  }

  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.companyService.remove(id);
  }
}
