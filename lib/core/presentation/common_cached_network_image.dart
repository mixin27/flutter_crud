import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'image_placeholder.dart';

class CommonCachedNetworkImage extends StatelessWidget {
  const CommonCachedNetworkImage({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.fit,
    this.alignment,
    this.usePlaceholderIfUrlEmpty = true,
    this.radius,
    this.color,
  }) : super(key: key);

  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  final bool usePlaceholderIfUrlEmpty;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return ImagePlaceholder(
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        radius: radius,
      );
    } else if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        color: color,
        alignment: alignment as Alignment? ?? Alignment.center,
        errorWidget: (_, s, d) => ImagePlaceholder(
          height: height,
          width: width,
          fit: fit,
          alignment: alignment,
          radius: radius,
        ),
        placeholder: (_, s) {
          if (!usePlaceholderIfUrlEmpty) return const SizedBox();
          return ImagePlaceholder(
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            radius: radius,
          );
        },
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.asset(
          url,
          height: height,
          width: width,
          fit: fit,
          alignment: alignment ?? Alignment.center,
        ),
      );
    }
  }
}
