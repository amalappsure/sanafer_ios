import 'package:base_ecom_appsure/features/app_settings/providers/app_config_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class UnderMaintenanceScreen extends ConsumerWidget {
  const UnderMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.read(appConfigProvider);
    return Scaffold(
      appBar: const AlSanaferAppBar(showActions: false),
      body: Center(
        child: Text(
          appConfig.siteUnderMaintenanceMessage,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
