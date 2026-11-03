import 'package:flutter_test/flutter_test.dart';
import 'package:life_insurance_monitoring_mobile/data/models/company_prroducts_reponse_model.dart';

void main() {
  group('CompanyProductsResponseModel.fromJson', () {
    test('parses string amount and payment term objects', () {
      final model = CompanyProductsResponseModel.fromJson({
        'id': 'product-1',
        'insuranceProductName': 'Starter Plan',
        'productContents': 'Life cover',
        'productAmount': '1250.50',
        'paymentTerms': [
          {'period': 'MONTHLY', 'amount': 7000},
          {'period': 'ANNUAL', 'amount': '12000.50'},
        ],
      });

      expect(model.id, 'product-1');
      expect(model.insuranceProductName, 'Starter Plan');
      expect(model.productAmount, 1250.50);
      expect(model.paymentTerms, hasLength(2));
      expect(model.paymentTerms[0].period, 'MONTHLY');
      expect(model.paymentTerms[0].amount, 7000.0);
      expect(model.paymentTerms[1].period, 'ANNUAL');
      expect(model.paymentTerms[1].amount, 12000.50);
    });

    test('uses zero when amount string is invalid', () {
      final model = CompanyProductsResponseModel.fromJson({
        'id': 'product-1',
        'insuranceProductName': 'Starter Plan',
        'productContents': 'Life cover',
        'productAmount': 'invalid-number',
        'paymentTerms': [],
      });

      expect(model.productAmount, 0.0);
    });

    test('accepts a numeric amount', () {
      final model = CompanyProductsResponseModel.fromJson({
        'id': 'product-1',
        'insuranceProductName': 'Starter Plan',
        'productContents': 'Life cover',
        'productAmount': 500,
        'paymentTerms': [],
      });

      expect(model.productAmount, 500.0);
    });

    test('throws when a payment term is not a map', () {
      expect(
        () => CompanyProductsResponseModel.fromJson({
          'id': 'product-1',
          'insuranceProductName': 'Starter Plan',
          'productContents': 'Life cover',
          'productAmount': '500',
          'paymentTerms': ['MONTHLY'],
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('CompanyProductsResponseModel.fromJsonList', () {
    test('parses multiple products', () {
      final result = CompanyProductsResponseModel.fromJsonList([
        {
          'id': 'product-1',
          'insuranceProductName': 'Starter Plan',
          'productContents': 'Life cover',
          'productAmount': '1000',
          'paymentTerms': [
            {'period': 'MONTHLY', 'amount': 7000},
          ],
        },
        {
          'id': 'product-2',
          'insuranceProductName': 'Premium Plan',
          'productContents': 'Life + accident',
          'productAmount': '2000',
          'paymentTerms': [
            {'period': 'MONTHLY', 'amount': 1000},
            {'period': 'QUARTERLY', 'amount': 2800},
          ],
        },
      ]);

      expect(result, hasLength(2));
      expect(result[0].productAmount, 1000.0);
      expect(result[1].paymentTerms.last.period, 'QUARTERLY');
      expect(result[1].paymentTerms.last.amount, 2800.0);
    });

    test('returns empty list when source list is empty', () {
      final result = CompanyProductsResponseModel.fromJsonList(
        const <dynamic>[],
      );

      expect(result, isEmpty);
    });

    test('throws when list item is not a map', () {
      expect(
        () => CompanyProductsResponseModel.fromJsonList(const <dynamic>[
          'bad-item',
        ]),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
