import 'package:base_ecom_appsure/features/auth/presentation/registration_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AlSanaferAppBar(
        showActions: true,
        showCart: false,
        showSearch: false,
      ),
      body: RegistrationView(),
    );
  }
}
