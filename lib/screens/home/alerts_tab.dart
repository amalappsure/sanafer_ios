import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class AlertsTab extends ConsumerWidget {
  const AlertsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Assets.svgs.alayshWhite.svg(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              settings.selectedLocale!.translate('Notifications'),
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
