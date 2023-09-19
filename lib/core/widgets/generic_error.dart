import 'package:flutter/material.dart';

class GenericError extends StatelessWidget {
  const GenericError({
    super.key,
    required this.errorText,
    required this.onRetry,
  });

  final String errorText;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
