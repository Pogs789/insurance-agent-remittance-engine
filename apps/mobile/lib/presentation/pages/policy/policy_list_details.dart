import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';
import 'package:life_insurance_monitoring_mobile/data/models/company_prroducts_reponse_model.dart';

class PolicyListDetails extends StatefulWidget {
  final CompanyProductsResponseModel companyProducts;
  const PolicyListDetails({
    super.key,
    required this.companyProducts
  });

  @override
  State<PolicyListDetails> createState() => _PolicyListDetailsState();
}

class _PolicyListDetailsState extends State<PolicyListDetails> {
  @override
  Widget build(BuildContext context) {
    final insuranceProduct = widget.companyProducts;
    final insuranceAmount = NumberFormat.decimalPattern('en-US').format(insuranceProduct.productAmount);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Text(
              insuranceProduct.insuranceProductName,
              style: TextStyle(fontSize: AppConstants.fontSizeXXL, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppConstants.mobilePadding),
            Text(
              insuranceProduct.productContents,
              style: TextStyle(fontSize: AppConstants.fontSizeMD),
            ),
            SizedBox(height: AppConstants.mobilePadding),
            Text(
              'Insurance Amount: ₱$insuranceAmount',
              style: TextStyle(fontSize: AppConstants.fontSizeLG, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppConstants.mobilePadding),
            Text(
              'Payment Terms',
              style: TextStyle(fontSize: AppConstants.fontSizeLG, fontWeight: FontWeight.bold),
            ),
            ///TODO: Update backend in such a way that payment terms (depending on company but for now (annually, semi-annually, quarterly and monthly)) is automatically calculated by the frontend
            ///EXAMPLE:
            ///Contract Price: P300k
            ///Annually: 60000
            ///Semi-Annually: 31800
            ///Quarterly: 16,500
            ///Monthly: 5,700
            ///The Goal is that, the Insurance Agent can simply select payment terms and the insurance product so that,
            ///the input from the backend is easily printed and calculated.

          ],
        ),
      ),
    );
  }
}

