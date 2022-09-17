import 'package:flutter/material.dart';

class LoginRegisterSwitch extends StatelessWidget {
  const LoginRegisterSwitch({
    Key? key,
    required this.text,
    required this.actionText,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String actionText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
