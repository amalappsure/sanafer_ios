import 'package:base_ecom_appsure/features/auth/presentation/login.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:sanafer/routes/app_router.gr.dart';

Future<void> showLoginBS(BuildContext context) => showModalBottomSheet(
  context: context,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
  ),
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  builder: (_) => Padding(
    padding: const EdgeInsets.only(top: 36),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          // padding: const EdgeInsets.all(16.0).copyWith(
          //   bottom: MediaQuery.of(context).viewInsets.bottom,
          // ),
          padding: const EdgeInsets.all(16.0),
          child: LoginView(
            parentContext: context,

            onResetPassword: () => context.pushRoute(
              const ResetPasswordRoute(),
            ),
            onCreateNewAccount: () async {
              final alreadyHaveAccount = await context.pushRoute(
                const RegistrationRoute(),
              );

              if (alreadyHaveAccount == true) {
                // ignore: use_build_context_synchronously
                showLoginBS(context);
              }
            },
          ),
        ),
      ),
    ),
  ),
);
