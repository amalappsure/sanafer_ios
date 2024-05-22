import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/auth/presentation/reset_password/reset_password_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        title: settings.selectedLocale!.translate('PasswordReset'),
        showActions: true,
        showCart: false,
        showSearch: false,
      ),
      body: Builder(
        builder: (context) => ResetPasswordView(
          scaffolContext: context,
        ),
      ),
    );
  }
}
