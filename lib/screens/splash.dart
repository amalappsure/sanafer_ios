import 'package:base_ecom_appsure/widgets/responsive_builder.dart';
import 'package:flutter/material.dart';

import 'package:sanafer/gen/assets.gen.dart';

import 'package:sanafer/theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const Spacer(),
            Responsive(
              mobile: (context, constraints, child) => Assets.images.smartsolns.image(
                width: MediaQuery.of(context).size.width * 0.45,
              ),
              desktop: (context, constraints, child) => Assets.images.smartsolns.image(
                height: MediaQuery.of(context).size.height * 0.45,
              ),
            ),
            const Spacer(),
            const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                  smartSuiteBlue,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
