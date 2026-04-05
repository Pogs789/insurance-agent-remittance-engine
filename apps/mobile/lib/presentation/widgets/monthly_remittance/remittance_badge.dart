import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';

import 'package:life_insurance_monitoring_mobile/core/themes/app_colors.dart';

class RemittanceBadge extends StatelessWidget {
  final double fontSize;
  final EdgeInsets padding;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const RemittanceBadge({
    super.key,
    this.fontSize = AppConstants.fontSizeXS,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    required this.text,
    this.backgroundColor = AppColors.colorWarningContainer,
    this.textColor = AppColors.colorWarning,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: textColor,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(icon != null) ... [
            Icon(
              icon,
              size: fontSize,
              color: textColor,
            ),
            const SizedBox(width: 4.0),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}