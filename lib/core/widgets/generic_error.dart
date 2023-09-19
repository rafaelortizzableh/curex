import 'package:flutter/material.dart';

import '../core.dart';

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
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorText,
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalSpacing16,
          AdaptiveButton.fromIconData(
            Icons.refresh,
            onPressed: onRetry,
            isLoading: false,
            isDisabled: false,
            backgroundColor: AppColors.errorRed,
            foregroundColor: Colors.white,
            child: Text(
              'Retry',
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
