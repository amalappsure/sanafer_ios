import 'package:base_ecom_appsure/features/edit_profile/presentation/change_password_bs.dart';
import 'package:base_ecom_appsure/features/edit_profile/presentation/edit_mobile_bs.dart';
import 'package:base_ecom_appsure/features/edit_profile/presentation/edit_name_bs.dart';
import 'package:base_ecom_appsure/foundation/hive_repo.dart';
import 'package:base_ecom_appsure/foundation/string_exts.dart';
import 'package:base_ecom_appsure/features/auth/providers/login_state_provider.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/widgets/default_card.dart';
import 'package:base_ecom_appsure/widgets/separated_layouts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    ref.watch(loginStateProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        title: settings.selectedLocale!.translate('Login&Security'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _titleAndValue(
              context,
              ref,
              onPressed: () => _showModalBottomSheet(
                context,
                const EditNameBS(),
              ),
              title: settings.selectedLocale!.translate('Name'),
              value: HiveRepo.instance.user?.name ?? '',
            ),
            _titleAndValue(
              context,
              ref,
              onPressed: () => context.pushRoute(const EditEmailRoute()),
              title: settings.selectedLocale!.translate('Email'),
              value: HiveRepo.instance.user?.email ?? '',
            ),
            _titleAndValue(
              context,
              ref,
              onPressed: () => _showModalBottomSheet(
                context,
                const EditMobileBS(),
              ),
              title: settings.selectedLocale!.translate('MobileNumber'),
              value: HiveRepo.instance.user?.mobile ?? '',
            ),
            if (HiveRepo.instance.user?.password != null)
              _titleAndValue(
                context,
                ref,
                onPressed: () => _showModalBottomSheet(
                  context,
                  const ChangePasswordBS(),
                ),
                title: settings.selectedLocale!.translate('Password'),
                value: (HiveRepo.instance.user?.password ?? '').mask('*'),
              ),
          ],
        ).separated(
          context,
          separatorBuilder: (context) => const Gap(12),
        ),
      ),
    );
  }

  Future<T?> _showModalBottomSheet<T>(
      BuildContext context,
      Widget widget,
      ) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => widget,
    );
  }

  Widget _titleAndValue(
      BuildContext context,
      WidgetRef ref, {
        required String title,
        required String value,
        VoidCallback? onPressed,
      }) =>
      DefaultCard(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      vertical: VisualDensity.minimumDensity,
                      horizontal: VisualDensity.minimumDensity,
                    ),
                  ),
                  child: Text(
                    ref
                        .read(settingsProvider)
                        .selectedLocale!
                        .translate('Edit'),
                  ),
                )
              ],
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      );
}
