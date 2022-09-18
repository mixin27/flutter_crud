import 'package:flutter/material.dart';

class ErrorPlaceholderWidget extends StatelessWidget {
  const ErrorPlaceholderWidget({
    super.key,
    this.message,
    this.icon,
    this.buttonText,
    this.onPressed,
  });

  final String? message;
  final IconData? icon;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon ?? Icons.error,
          size: 80,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(70),
        ),
        const SizedBox(height: 10),
        Text(
          message ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (onPressed != null) const SizedBox(height: 10),
        if (onPressed != null)
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ),
            ),
            child: Text(buttonText ?? 'Try Again'),
          ),
      ],
    );
  }
}
