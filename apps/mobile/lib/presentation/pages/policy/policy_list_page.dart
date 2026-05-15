import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';
import 'package:life_insurance_monitoring_mobile/core/themes/app_colors.dart';

class PolicyListPage extends StatefulWidget {
  const PolicyListPage({super.key});

  @override
  State<PolicyListPage> createState() => _PolicyListPageState();
}

class _PolicyListPageState extends State<PolicyListPage> {
  final List<Map<String, String>> _draftPolicies = const [
    {
      'name': 'St. John',
      'contractPrice': '300,000.00',
      'packageContents': '1,250.00',
    },
    {
      'name': 'St. Paul',
      'contractPrice': '160,000.00',
      'packageContents': '925.00',
    },
    {
      'name': 'St. Ferdinand',
      'contractPrice': '105,000.00',
      'packageContents': '2,100.00',
    },
    {
      'name': 'St. Francis',
      'contractPrice': '100,000.00',
      'packageContents': '2,100.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        itemCount: _draftPolicies.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppConstants.spaceMD),
        itemBuilder: (context, index) {
          final policy = _draftPolicies[index];
          return Card(
            elevation: 2,
            color: AppColors.colorInfoContainer.withValues(alpha: 0.18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
              side: BorderSide(
                color: AppColors.colorInfo.withValues(alpha: 0.12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spaceLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    policy['name'] ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spaceMD),
                  _PolicyDetailRow(
                    label: 'Contract Price',
                    value: policy['contractPrice'] ?? '',
                  ),
                  const SizedBox(height: AppConstants.spaceSM),
                  _PolicyDetailRow(
                    label: 'Package Contents',
                    value: policy['commission'] ?? '',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PolicyDetailRow extends StatelessWidget {
  const _PolicyDetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.75),
                ),
          ),
        ),
        const SizedBox(width: AppConstants.spaceMD),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '₱',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.colorInfo,
                      fontWeight: FontWeight.w600,
                      fontSize: AppConstants.amountFontSizeMobile,
                    ),
              ),
              const SizedBox(width: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppConstants.amountFontSizeMobile,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}