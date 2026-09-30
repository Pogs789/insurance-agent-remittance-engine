import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/storage_constants.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/models/company_prroducts_reponse_model.dart';

/// Handles company-product caching once offline-first support is added.
abstract class CompanyLocalDataSource {
  Future<void> saveCompanyInsuranceProducts(
    List<CompanyProductsResponseModel> products,
  );

  Future<List<CompanyProductsResponseModel>> getCompanyInsuranceProducts();
  Future<double> getCompanyInsuranceRates();
}

class CompanyLocalDataSourceImpl implements CompanyLocalDataSource {
  @override
  Future<void> saveCompanyInsuranceProducts(
    List<CompanyProductsResponseModel> products,
  ) {
    // TODO: implement local caching for company products.
    throw UnimplementedError();
  }

  @override
  Future<List<CompanyProductsResponseModel>> getCompanyInsuranceProducts() {
    // TODO: implement local read for company products.
    throw UnimplementedError();
  }

  @override
  Future<double> getCompanyInsuranceRates() async {
    final session = await AuthLocalDataSourceImpl().getSession();
    return session?.commissionRate ?? 0.0;
  }
}

