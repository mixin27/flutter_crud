import 'package:flutter/material.dart';
import 'package:smf_core/smf_core.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ALC.getHeight(200),
      padding: EdgeInsets.symmetric(
        horizontal: ALC.getWidth(20),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(''), // AppAssets.yourAppLogo
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
