import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/domain/entities/planholders.dart';
import 'package:life_insurance_monitoring_mobile/data/datasources/local/auth_local_datasource.dart';

class PlanholderRow extends StatefulWidget {
  final int index;
  final PlanholderData data;
  final VoidCallback onRemove;

  const PlanholderRow({super.key,
    required this.index,
    required this.data,
    required this.onRemove,
  });

  @override
  State<PlanholderRow> createState() => _PlanholderRowState();
}

class _PlanholderRowState extends State<PlanholderRow> {
  late final AuthLocalDataSource auth;
  bool _showInsuranceInput = false;

  @override
  void initState() {
    super.initState();
    auth = AuthLocalDataSourceImpl();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final userId = await auth.isLoggedIn();
    if(!mounted) return;
    setState(() {
      _showInsuranceInput = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical:4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Planholder #${widget.index +1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            TextFormField(
              initialValue: widget.data.planholderName,
              decoration: const InputDecoration(
                labelText: 'Planholder Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              onChanged: (v) => widget.data.planholderName = v,
            ),
            const SizedBox(height:8),
            if(_showInsuranceInput)...[
              TextFormField(
                initialValue: widget.data.insuranceProduct,
                decoration: const InputDecoration(
                  labelText: 'Insurance Product',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                onChanged: (v) => widget.data.insuranceProduct = v,
              ),
              const SizedBox(height:8),
              TextFormField(
                initialValue:
                widget.data.insuranceAmount >0 ? widget.data.insuranceAmount.toString() : '',
                decoration: const InputDecoration(
                  labelText: 'Insurance Amount (₱)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                onChanged: (v) {
                  widget.data.insuranceAmount = double.tryParse(v) ??0.0;
                },
              ),
              const SizedBox(height:8),
            ],
            DropdownButtonFormField<PaymentPeriod>(
              value: widget.data.paymentPeriod,
              decoration: const InputDecoration(
                labelText: 'Payment Period',
                border: OutlineInputBorder(),
              ),
              items: PaymentPeriod.values.map((e) {
                return DropdownMenuItem<PaymentPeriod>(
                  value: e,
                  child: Text(e.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (v) {
                widget.data.paymentPeriod = v ?? PaymentPeriod.monthly;
              },
            ),
            const SizedBox(height:8),
            TextFormField(
              initialValue: widget.data.paymentPeriodAmount >0 ? widget.data.paymentPeriodAmount.toString()
                  : '',
              decoration: const InputDecoration(
                labelText: 'Amount Due (₱)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              onChanged: (v) {
                widget.data.paymentPeriodAmount = double.tryParse(v) ??0.0;
              },
            ),
            const SizedBox(height:8),
            DropdownButtonFormField<PlanholderStatus>(
              value: widget.data.planholderStatus,
              decoration: const InputDecoration(
                labelText: 'Planholder Status',
                border: OutlineInputBorder(),
              ),
              items: PlanholderStatus.values.map((e) {
                return DropdownMenuItem<PlanholderStatus>(
                  value: e,
                  child: Text(e.name.toUpperCase()),
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