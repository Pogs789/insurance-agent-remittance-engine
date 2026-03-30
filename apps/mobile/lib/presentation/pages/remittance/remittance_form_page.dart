import 'package:dio/dio.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/remote/monthly_remittance_remote_datasource.dart';
import 'package:life_insurance_monitoring_mobile/data/repositories/monthly_remittance_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/monthly_remittance.dart';
import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/planholders.dart';
import 'package:life_insurance_monitoring_mobile/domain/repositories/monthly_remittance_repository.dart';
import 'package:life_insurance_monitoring_mobile/domain/usecases/monthly_remittance/submit_monthly_remittance_usecase.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/auth/login_page.dart';
import 'package:life_insurance_monitoring_mobile/presentation/pages/auth/registration_page.dart';
import 'package:provider/provider.dart';
import 'package:life_insurance_monitoring_mobile/presentation/providers/monthly_remittance/monthly_remittance_provider.dart';
import 'package:life_insurance_monitoring_mobile/presentation/widgets/monthly_remittance/monthly_remittance_form_inputs.dart';

import '../../widgets/monthly_remittance/monthly_remittance_dialog.dart';

class RemittanceFormPage extends StatefulWidget {
  const RemittanceFormPage({super.key});

  @override State<RemittanceFormPage> createState() => _RemittanceFormPageState();
}

class _RemittanceFormPageState extends State<RemittanceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final List<PlanholderData> _planholders = <PlanholderData>[];
  double _commissionRate = 0.0;
  late final SubmitMonthlyRemittanceUseCase submitMonthlyRemittanceUseCase;
  late final MonthlyRemittanceRepository repository;
  late final MonthlyRemittanceRemoteDataSource remote;
  late final AuthLocalDataSource auth;

  @override
  void initState() {
    super.initState();
    remote = MonthlyRemittanceRemoteDataSourceImpl(dio: Dio());
    repository = MonthlyRemittanceRepositoryImpl(remote);
    submitMonthlyRemittanceUseCase = SubmitMonthlyRemittanceUseCase(repository);
    auth = AuthLocalDataSourceImpl();
  }

  PlanholderData _createEmptyPlanholder() {
    return PlanholderData(
      planholderName: '',
      insuranceProduct: '',
      insuranceAmount:0.0,
      paymentPeriod: PaymentPeriod.monthly,
      paymentPeriodAmount:0.0,
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final provider = providerContext.read<MonthlyRemittanceProvider>();

      await provider.submit(
        MonthlyRemittance(
          commissionRate: _commissionRate,
          planholderData: _planholders
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MonthlyRemittanceProvider(
            SubmitMonthlyRemittanceUseCase(
              MonthlyRemittanceRepositoryImpl(
                MonthlyRemittanceRemoteDataSourceImpl(dio: Dio())
              )
            )
        ),
      child: Builder(
        builder: (providerContext) {
          final provider = providerContext.watch<MonthlyRemittanceProvider>();

          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //FIXME: fontSize must depend on the type of device a person would access.
                  Text('Monthly Remittance Calculator'),
                  Row(
                    spacing: 10.0,
                    children: [
                      Text(
                          'Want to view your remittance history? You can register to view it.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          )
                      ),
                      IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrationPage())
                        ),
                        icon: Icon(
                            Icons.app_registration
                        ),
                      ),
                      IconButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage())
                          ),
                          icon: Icon(
                              Icons.login
                          )
                      )
                    ],
                  )
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
                      Center(
                        child: Row(
                          children: [
                            Text(
                              'Your Commission Rate (%): ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                initialValue: '0',
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                                onChanged: (v) {
                                  _commissionRate = double.tryParse(v) ?? 0.0;
                                },
                              ),
                            )
                          ]
                        ),
                      ),
                      const SizedBox(height:24),
                      const Divider(),
                      Text(
                        'Planholders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:16,
                        ),
                      ),
                      const SizedBox(height:12),
                      //This section of code is for an insurance agent to input necessary data related to their own insurance company.
                      if (_planholders.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'No planholders yet. Tap \'Add Planholder\' to begin.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      if (_planholders.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _planholders.length,
                          separatorBuilder: (_, __) => const SizedBox(height:8),
                          itemBuilder: (context, index) {
                            return PlanholderRow(
                              index: index,
                              data: _planholders[index],
                              onRemove: () => _removeRow(index),
                            );
                          },
                        ),
                      const SizedBox(height:24),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount to be Remitted:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:16,
                            ),
                          ),
                          Text(
                            '₱ ${provider.amountToBeRemitted.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize:16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height:24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : () async {
                            if(_planholders.isEmpty) {
                              await MonthlyRemittanceDialog.show(
                                context,
                                title: 'Input Error',
                                message: 'Please add first your planholder before calculating the remittance needed.',
                                showConfirmationDialog: false,
                                cancelLabel: 'Okay'
                              );

                              return;
                            }

                            final confirmed = await MonthlyRemittanceDialog.show(
                              context,
                              title: 'Confirmation',
                              message: 'Are you sure that the planholders that you inputted were correct? Please double check your inputs before calculating the remittance needed.',
                            );

                            if(confirmed == true) {
                              _submitForm(providerContext);
                              return;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical:16),
                          ),
                          child: provider.isLoading ? const CircularProgressIndicator() : const Text('Calculate Total Amount Needed to be Remitted'),
                        ),
                      ),
                      if(provider.errorMessage != null)
                        Text(
                          provider.errorMessage!,
                          style: const TextStyle(
                            color: Colors.red
                          )
                        ),
                      if(provider.isSuccess)
                        const Text(
                          'Form Submitted. The Amount to be remitted is already shown in the results.',
                          style: TextStyle(color: Colors.green)
                        )
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: _addRow,
              label: Row(
                children: [
                  Icon(Icons.add),
                  Text('Add Planholder'),
                ]
              ),
            ),
          );
        }
      )
    );
  }
}