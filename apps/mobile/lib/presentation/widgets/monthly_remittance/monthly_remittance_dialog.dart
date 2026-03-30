import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';

class MonthlyRemittanceDialog extends StatelessWidget {
  final String dialogueTitle;
  final String dialogueMessage;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String confirmLabel;
  final String cancelLabel;
  final bool showConfirmationButton;

  // Brand colours kept in sync with AppTheme's finance palette.
  static const Color _brandError = Color(0xFFB00020); // AppTheme._error
  static const Color _iconBg     = Color(0xFFFFE4E6); // soft red tint

  const MonthlyRemittanceDialog({
    super.key,
    required this.dialogueTitle,
    required this.dialogueMessage,
    required this.onConfirm,
    this.onCancel,
    this.confirmLabel = 'Confirm',
    this.cancelLabel  = 'Cancel',
    required this.showConfirmationButton
  });

  /// Convenience method – returns [true] on confirm, [false] on cancel,
  /// [null] if dismissed (though `barrierDismissible` is false).
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    bool showConfirmationDialog = true,
    String confirmLabel = 'Confirm',
    String cancelLabel  = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => MonthlyRemittanceDialog(
        dialogueTitle: title,
        dialogueMessage: message,
        confirmLabel: confirmLabel,
        cancelLabel:  cancelLabel,
        onConfirm: () => Navigator.of(dialogContext).pop(true),
        onCancel:  () => Navigator.of(dialogContext).pop(false),
        showConfirmationButton: showConfirmationDialog,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We intentionally do NOT use [context] for Navigator calls because this
    // widget is inserted into the dialog overlay – its ancestor Navigator is
    // the one that owns the dialog route.  Using the wrong context here is
    // what causes "Unexpected null value" at Navigator.of(context).state.
    final theme       = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceXXL, // 32
          vertical:   AppConstants.spaceXXL, // 32
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Warning icon ──────────────────────────────────────────────
            Container(
              decoration: const BoxDecoration(
                color: _iconBg,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(AppConstants.spaceXL), // 24
              child: const Icon(
                Icons.warning_amber_rounded,
                size: 36,
                color: _brandError,
              ),
            ),
            const SizedBox(height: AppConstants.spaceXL), // 24

            // ── Title ─────────────────────────────────────────────────────
            Text(
              dialogueTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: AppConstants.spaceMD), // 12

            // ── Message ───────────────────────────────────────────────────
            Text(
              dialogueMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Inter',
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppConstants.spaceXXL), // 32

            // ── Action buttons ────────────────────────────────────────────
            Row(
              children: [
                // Cancel ─────────────────────────────────────────────────
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (onCancel != null) {
                        onCancel!();
                      } else {
                        // Use the dialog's own context so Navigator.of() finds
                        // the overlay route, not the underlying page's route.
                        Navigator.of(context, rootNavigator: true).pop(false);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConstants.spaceLG, // 16
                      ),
                      side: BorderSide(color: colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.cardBorderRadius,
                        ),
                      ),
                    ),
                    child: Text(
                      cancelLabel,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spaceMD), // 12

                // Confirm ────────────────────────────────────────────────
                if(showConfirmationButton)
                Expanded(
                  child: FilledButton(
                    onPressed: onConfirm,
                    style: FilledButton.styleFrom(
                      backgroundColor: _brandError,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConstants.spaceLG, // 16
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.cardBorderRadius,
                        ),
                      ),
                    ),
                    child: Text(
                      confirmLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}