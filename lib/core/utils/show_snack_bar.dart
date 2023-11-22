import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, bool isSuccessful) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isSuccessful ? Colors.green : Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}
