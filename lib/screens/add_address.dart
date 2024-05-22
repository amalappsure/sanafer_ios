import 'package:base_ecom_appsure/features/addresses/models/address.dart';
import 'package:base_ecom_appsure/features/addresses/presentation/add_address_form.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';


@RoutePage()
class AddAddressScreen extends ConsumerWidget {
  const AddAddressScreen({
    super.key,
    this.address,
  });

  final Address? address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        title: settings.selectedLocale!.translate('NewDeliveryAddress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: AddAddressForm(
          address: address,
        ),
      ),
    );
  }
}
