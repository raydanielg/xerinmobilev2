import 'package:flutter/material.dart';

import '../../../config/constants/app_constants.dart';

/// Reusable primary/secondary button.
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final bool isFullWidth;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isSecondary = false,
    this.isFullWidth = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    final style = isSecondary
        ? OutlinedButton.styleFrom(
            minimumSize: isFullWidth
                ? const Size(double.infinity, AppConstants.buttonHeight)
                : const Size(0, AppConstants.buttonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
            side: BorderSide(color: colorScheme.primary),
          )
        : ElevatedButton.styleFrom(
            minimumSize: isFullWidth
                ? const Size(double.infinity, AppConstants.buttonHeight)
                : const Size(0, AppConstants.buttonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          );

    return isSecondary
        ? OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: style,
            child: child,
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: style,
            child: child,
          );
  }
}
