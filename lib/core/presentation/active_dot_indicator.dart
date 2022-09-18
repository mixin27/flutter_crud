import 'package:flutter/material.dart';

class ActiveDotIndicator extends StatelessWidget {
  const ActiveDotIndicator({
    Key? key,
    this.active = false,
    this.size,
    this.radius,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  final bool active;
  final double? size;
  final double? radius;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final activeFillColor = activeColor ?? Colors.greenAccent;
    final inactiveFillColor = inactiveColor ?? Colors.grey;

    return Container(
      width: size ?? 10,
      height: size ?? 10,
      decoration: BoxDecoration(
        color: active ? activeFillColor : inactiveFillColor,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
