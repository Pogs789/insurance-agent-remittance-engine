import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/remote/monthly_remittance_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/repositories/monthly_remittance_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';
import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/planholders.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/monthly_remittance_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/monthly_remittance/monthly_remittance_usecase.dart';
import 'package:life_insurance_monitoring_mobile/presentation/widgets/monthly_remittance/remittance_badge.dart';
import 'package:provider/provider.dart';
import 'package:life_insurance_monitoring_mobile/presentation/providers/monthly_remittance/monthly_remittance_provider.dart';
import 'package:life_insurance_monitoring_mobile/presentation/providers/company/company_provider.dart';
import 'package:life_insurance_monitoring_mobile/data/models/company_prroducts_reponse_model.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/remote/company_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/repositories/company_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/company/company_usecase.dart';

import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';
import 'package:life_insurance_monitoring_mobile/presentation/widgets/monthly_remittance/monthly_remittance_dialog.dart';
import 'package:life_insurance_monitoring_mobile/core/app_globals.dart';

import '../../../core/themes/app_colors.dart';

class RemittanceFormPage extends StatefulWidget {
  const RemittanceFormPage({super.key});

  @override
  State<RemittanceFormPage> createState() => _RemittanceFormPageState();
}

class _RemittanceFormPageState extends State<RemittanceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final List<PlanholderData> _planholders = <PlanholderData>[];
  double _commissionRate = 0.0;
  late final MonthlyRemittanceUseCase submitMonthlyRemittanceUseCase;
  late final MonthlyRemittanceRepository repository;
  late final MonthlyRemittanceRemoteDataSource remote;
  late final AuthLocalDataSource auth;
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    auth = AuthLocalDataSourceImpl();
    remote = MonthlyRemittanceRemoteDataSourceImpl(dio: getAppDio());
    repository = MonthlyRemittanceRepositoryImpl(remote);
    submitMonthlyRemittanceUseCase = MonthlyRemittanceUseCase(repository);
    _loadUserId();
  }

  PlanholderData _createEmptyPlanholder() {
    return PlanholderData(
      planholderName: '',
      insuranceProduct: '',
      insuranceAmount: 0.0,
      paymentPeriod: PaymentPeriod.monthly,
      paymentPeriodAmount: 0.0,
      planholderStatus: PlanholderStatus.active,
    );
  }

  void _addRow() {
    final newPlanholder = _createEmptyPlanholder();
    setState(() {
      _planholders.add(newPlanholder);
    });
  }

  void _removeRow(int index) {
    setState(() {
      _planholders.removeAt(index);
    });
  }

  void _submitForm(BuildContext providerContext) async {
    final provider = providerContext.read<MonthlyRemittanceProvider>();

    await provider.submit(
      MonthlyRemittance(
        commissionRate: _commissionRate,
        planholderData: _planholders,
      ),
    );
  }

  Future<void> _loadUserId() async {
    final bool isLoggedIn = await auth.isLoggedIn();
    if (!mounted) return;

    final session = await auth.getSession();
    setState(() {
      _isUserLoggedIn = isLoggedIn;
      if(session != null) {
        _commissionRate = session.commissionRate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MonthlyRemittanceProvider(
        MonthlyRemittanceUseCase(
          MonthlyRemittanceRepositoryImpl(
            MonthlyRemittanceRemoteDataSourceImpl(dio: getAppDio()),
          ),
        ),
      ),
      child: Builder(
        builder: (providerContext) {
          final provider = providerContext.watch<MonthlyRemittanceProvider>();

          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Remittance Calculator'),
                  if(_isUserLoggedIn == false)
                  Row(
                    spacing: 10.0,
                    children: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                        icon: Icon(Icons.app_registration),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        icon: Icon(Icons.login),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(!_isUserLoggedIn) ...[
                      Text(
                        'Want to view your remittance history? You can register to view it.',
                        style: TextStyle(
                          fontSize: AppConstants.fontSizeSM,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 24),
                      ],
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Commission Rate (%): ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.fontSizeMD,
                              ),
                            ),
                            const SizedBox(width: 12),
                            if(_isUserLoggedIn == false) ...[
                              Expanded(
                                child: TextFormField(
                                  initialValue: '0',
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'),
                                    ),
                                  ],
                                  keyboardType: const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Please enter your commission rate set by your company.';
                                    }

                                    final rate = double.tryParse(v);

                                    if (rate == null) {
                                      return 'Please enter a valid number';
                                    }

                                    if (rate < 0) {
                                      return 'Percentage cannot be negative';
                                    }

                                    if (rate > 100) {
                                      return 'Percentage cannot exceed 100%';
                                    }

                                    return null;
                                    },
                                  onChanged: (v) {
                                    _commissionRate = double.tryParse(v) ?? 0.0;
                                  },
                                ),
                              ),
                            ] else ...[
                              RemittanceBadge(
                                text: '${_commissionRate.toString()}%',
                                fontSize: AppConstants.fontSizeXXL,
                                backgroundColor: AppColors.colorInfo,
                                textColor: AppColors.colorOnInfo,
                              )
                            ]
                          ]
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount to be Remitted:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstants.fontSizeMD,
                            ),
                          ),
                          RemittanceBadge(
                            text: 'P ${provider.amountToBeRemitted.toStringAsFixed(2)}',
                            fontSize: AppConstants.fontSizeLG,
                            backgroundColor: AppColors.colorOnSuccessContainer,
                            textColor: AppColors.colorOnSuccess,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: RemittanceBadge(
                          text:
                              'NOTE: This is only a demo. We are upgrading this tool to make it more convenient to you. So stay tuned...',
                          icon: Icons.info,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      Text(
                        'Planholders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      //This section of code is for an insurance agent to input necessary data related to their own insurance company.
                      if (_planholders.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'No planholders yet. Tap \'Add Planholder\' to begin.',
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                        ),
                      if (_planholders.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _planholders.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return PlanholderRow(
                              index: index,
                              data: _planholders[index],
                              onRemove: () => _removeRow(index),
                            );
                          },
                        ),
                      const SizedBox(height: 24),
                      const Divider(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    if (_planholders.isEmpty) {
                                      await MonthlyRemittanceDialog.show(
                                        context,
                                        title: 'Input Error',
                                        message:
                                            'Please add first your planholder before calculating the remittance needed.',
                                        showConfirmationDialog: false,
                                        cancelLabel: 'Okay',
                                      );

                                      return;
                                    }

                                    final confirmed =
                                        await MonthlyRemittanceDialog.show(
                                          context,
                                          title: 'Confirmation',
                                          message:
                                              'Are you sure that the planholders that you inputted were correct? Please double check your inputs before calculating the remittance needed.',
                                        );

                                    if (confirmed == true) {
                                      if(!providerContext.mounted) return;
                                      _submitForm(providerContext);
                                      return;
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Theme.of(
                              context,
                            ).primaryColorLight,
                          ),
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Calculate Total Amount Needed to be Remitted',
                                  style: TextStyle(
                                    color: AppColors.colorInfo,
                                    fontSize: AppConstants.fontSizeMD,
                                  ),
                                ),
                        ),
                      ),
                      if (provider.errorMessage != null)
                        Text(
                          provider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      if (provider.isSuccess)
                        const Text(
                          'Form Submitted. The Amount to be remitted is already shown in the results.',
                          style: TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: _addRow,
              label: Row(children: [Icon(Icons.add), Text('Add Planholder')]),
            ),
          );
        },
      ),
    );
  }
}

class PlanholderRow extends StatefulWidget {
  final int index;
  final PlanholderData data;
  final VoidCallback onRemove;

  const PlanholderRow({
    super.key,
    required this.index,
    required this.data,
    required this.onRemove,
  });

  @override
  State<PlanholderRow> createState() => _PlanholderRowState();
}

class _PlanholderRowState extends State<PlanholderRow> {
  late final AuthLocalDataSource auth;
  late final CompanyProvider companyProvider;
  bool _showInsuranceInput = false;
  List<CompanyProductsResponseModel> _companyProducts = [];
  CompanyProductsResponseModel? _selectedProduct;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _paymentAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    auth = AuthLocalDataSourceImpl();
    _initializeCompanyProvider();
    _loadUserId();

    if (widget.data.paymentPeriodAmount > 0) {
      _paymentAmountController.text = widget.data.paymentPeriodAmount.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _paymentAmountController.dispose();
    super.dispose();
  }

  void _initializeCompanyProvider() {
    final dio = getAppDio();
    final remoteDataSource = CompanyRemoteDataSourceImpl(dio: dio);
    final repository = CompanyRepositoryImpl(remoteDataSource);
    companyProvider = CompanyProvider(
      GetCompanyUseCase(repository),
      GetCompanyProductsUseCase(repository),
    );
  }

  Future<void> _loadUserId() async {
    final bool isLoggedIn = await auth.isLoggedIn();
    if (!mounted) return;
    setState(() {
      _showInsuranceInput = isLoggedIn;
    });
    
    if (isLoggedIn) {
      _loadCompanyProducts();
    }
  }

  Future<void> _loadCompanyProducts() async {
    try {
      final products = await companyProvider.getCompanyInsuranceProducts();
      if (!mounted) return;
      setState(() {
        _companyProducts = products;
        if (products.isNotEmpty && widget.data.insuranceProduct.isEmpty) {
          _selectedProduct = products.first;
          widget.data.insuranceProduct = products.first.insuranceProductName;
          widget.data.insuranceAmount = products.first.productAmount;
        } else if (products.isNotEmpty) {
          _selectedProduct = products.firstWhere(
            (p) => p.insuranceProductName == widget.data.insuranceProduct,
            orElse: () => products.first,
          );
        }

        if (_selectedProduct != null) {
          _amountController.text = 'P ${_selectedProduct!.productAmount.toStringAsFixed(2)}';
          widget.data.insuranceAmount = _selectedProduct!.productAmount;
          _updatePaymentAmount();
        }
      });
    } catch (e) {
      debugPrint('Error loading company products: $e');
    }
  }

  void _updatePaymentAmount() {
    double divisor = 1.0;
    switch (widget.data.paymentPeriod) {
      case PaymentPeriod.monthly:
        divisor = 60.0;
        break;
      case PaymentPeriod.quarterly:
        divisor = 30.0;
        break;
      case PaymentPeriod.semiannually:
        divisor = 10.0;
        break;
      case PaymentPeriod.annually:
        divisor = 5.0;
        break;
      case PaymentPeriod.spotOn:
        break;
    }

    final calculatedAmount = widget.data.insuranceAmount / divisor;
    widget.data.paymentPeriodAmount = calculatedAmount;
    _paymentAmountController.text = calculatedAmount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Planholder #${widget.index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            //Planholder Name
            TextFormField(
              initialValue: widget.data.planholderName,
              decoration: const InputDecoration(
                labelText: 'Name of Planholder',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'This field is required.'
                  : null,
              onChanged: (v) => widget.data.planholderName = v,
            ),
            const SizedBox(height: 8),
            if (_showInsuranceInput) ...[
              //Insurance Product
              DropdownButtonFormField<CompanyProductsResponseModel>(
                initialValue: _selectedProduct,
                decoration: const InputDecoration(
                  labelText: 'Insurance Product',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                items: _companyProducts.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.insuranceProductName),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null) {
                    widget.data.insuranceProduct = v.insuranceProductName;
                    widget.data.insuranceAmount = v.productAmount;
                    setState(() {
                      _selectedProduct = v;
                      _amountController.text = 'P ${v.productAmount.toStringAsFixed(2)}';
                      _updatePaymentAmount();
                    });
                  }
                },
              ),
              const SizedBox(height: 8),
              //Product Amount
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  enabled: false,
                  labelText: 'Insurance Amount (P)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                onChanged: (v) {
                  widget.data.insuranceAmount = double.tryParse(v) ?? 0.0;
                },
              ),
              const SizedBox(height: 8),
            ],
            //Payment Period
            DropdownButtonFormField<PaymentPeriod>(
              initialValue: widget.data.paymentPeriod,
              decoration: const InputDecoration(
                labelText: 'Payment Period',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              items: PaymentPeriod.values.map((e) {
                return DropdownMenuItem<PaymentPeriod>(
                  value: e,
                  child: Text(e.displayName),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  widget.data.paymentPeriod = v ?? PaymentPeriod.monthly;
                  _updatePaymentAmount();
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _paymentAmountController,
              decoration: const InputDecoration(
                labelText: 'Amount Due (P) - Calculated',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              readOnly: true,
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'This field is required.'
                  : null,
              onChanged: (v) {
                widget.data.paymentPeriodAmount = double.tryParse(v) ?? 0.0;
              },
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<PlanholderStatus>(
              initialValue: widget.data.planholderStatus,
              decoration: const InputDecoration(
                labelText: 'Planholder Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              items: PlanholderStatus.values.map((e) {
                return DropdownMenuItem<PlanholderStatus>(
                  value: e,
                  child: Text(e.displayName),
                );
              }).toList(),
              onChanged: (v) {
                widget.data.planholderStatus = v ?? PlanholderStatus.active;
              },
            ),
          ],
        ),
      ),
    );
  }
}

