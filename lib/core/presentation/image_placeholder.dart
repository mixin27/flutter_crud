import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
    this.height,
    this.width,
    this.fit,
    this.alignment,
    this.radius,
  });

  final double? height;
  final double? width;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.0)),
      child: Image.asset(
        'assets/images/placeholder.jpg',
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }
}
