import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/edit_profile/presentation/edit_email_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class EditEmailScreen extends ConsumerWidget {
  const EditEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        title: settings.selectedLocale!.translate(
          'ChangeEmail',
        ),
      ),
      body: const EditEmailView(),
    );
  }
}
