import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Global logger instance for the app.
final Logger logger = Logger();

/// Helper for showing quick snackbars.
void showSnackBar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

/// Helper for dismissing keyboard.
void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

/// Helper for formatting numbers as two digits.
String twoDigits(int n) => n.toString().padLeft(2, '0');
