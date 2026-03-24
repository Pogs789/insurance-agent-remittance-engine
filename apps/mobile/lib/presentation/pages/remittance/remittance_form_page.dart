import 'package:life_insurance_monitoring_mobile/data/models/planholder_data_model.dart';
import 'package:flutter/material.dart';

class RemittanceFormPage extends StatefulWidget {
  const RemittanceFormPage({super.key});

  @override State<RemittanceFormPage> createState() => _RemittanceFormPageState();
}

class _RemittanceFormPageState extends State<RemittanceFormPage> {
  final _formKey = GlobalKey<FormState>();
  double _amountRemitted =0.0;
  final List<PlanholderData> _planholders = <PlanholderData>[];

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted!')),
      );
    }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Remittance Form'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Your Commission Rate (%):40%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:18,
                    ),
                  ),
                ),
                const SizedBox(height:24),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Planholders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:16,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _addRow,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Row'),
                    ),
                  ],
                ),
                const SizedBox(height:12),
                if (_planholders.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'No planholders yet. Tap Add Row to begin.',
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
                      return _PlanholderRow(
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
                      'Total Amount Remitted:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:16,
                      ),
                    ),
                    Text(
                      '₱ ${_amountRemitted.toStringAsFixed(2)}',
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
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical:16),
                    ),
                    child: const Text('Submit Remittance'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanholderRow extends StatelessWidget {
  final int index;
  final PlanholderData data;
  final VoidCallback onRemove;

  const _PlanholderRow({
    required this.index,
    required this.data,
    required this.onRemove,
  });

  @override Widget build(BuildContext context) {
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
                  'Planholder #${index +1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
            TextFormField(
              initialValue: data.planholderName,
              decoration: const InputDecoration(
                labelText: 'Planholder Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              onChanged: (v) => data.planholderName = v,
            ),
            const SizedBox(height:8),
            TextFormField(
              initialValue: data.insuranceProduct,
              decoration: const InputDecoration(
                labelText: 'Insurance Product',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              onChanged: (v) => data.insuranceProduct = v,
            ),
            const SizedBox(height:8),
            TextFormField(
              initialValue:
              data.insuranceAmount >0 ? data.insuranceAmount.toString() : '',
              decoration: const InputDecoration(
                labelText: 'Insurance Amount (₱)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              onChanged: (v) {
                data.insuranceAmount = double.tryParse(v) ??0.0;
              },
            ),
            const SizedBox(height:8),
            DropdownButtonFormField<PaymentPeriod>(
              value: data.paymentPeriod,
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
                data.paymentPeriod = v ?? PaymentPeriod.monthly;
              },
            ),
            const SizedBox(height:8),
            TextFormField(
              initialValue: data.paymentPeriodAmount >0 ? data.paymentPeriodAmount.toString()
                  : '',
              decoration: const InputDecoration(
                labelText: 'Payment Period Amount (₱)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              onChanged: (v) {
                data.paymentPeriodAmount = double.tryParse(v) ??0.0;
              },
            ),
            const SizedBox(height:8),
            DropdownButtonFormField<PlanholderStatus>(
              value: data.planholderStatus,
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
                data.planholderStatus = v ?? PlanholderStatus.active;
              },
            ),
          ],
        ),
      ),
    );
  }
}
