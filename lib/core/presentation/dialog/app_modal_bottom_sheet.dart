import 'package:flutter/material.dart';

class AppModalBottomSheet extends StatelessWidget {
  const AppModalBottomSheet({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: child,
    );
  }
}
