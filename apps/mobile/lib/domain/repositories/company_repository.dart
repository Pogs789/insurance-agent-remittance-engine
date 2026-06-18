import 'package:life_insurance_monitoring_mobile/data/models/company_response_model.dart';

abstract class CompanyRepository {
  Future<List<CompanyResponseModel>> getAllCompaniesAndCommissionRates();
}