import 'package:base_ecom_appsure/features/addresses/presentation/address_item.dart';
import 'package:base_ecom_appsure/features/addresses/providers/address_provider.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class AddressesScreen extends ConsumerStatefulWidget {
  const AddressesScreen({super.key});

  @override
  ConsumerState<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends ConsumerState<AddressesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => _loadData(),
    );
    super.initState();
  }

  Future<void> _loadData() => ref.read(addressProvider).getAddressList();

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final addresses = ref.watch(addressesProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        title: settings.selectedLocale!.translate('YourAddresses'),
      ),
      body: addresses.when<Widget>(
        onLoading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        onSuccess: (data) {
          return RefreshIndicator(
            onRefresh: _loadData,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0).copyWith(
                bottom: 80.0,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) => AddressItem(
                address: data[index],
                onEditClicked: () => context.pushRoute(
                  AddAddressRoute(address: data[index]),
                ),
              ),
            ),
          );
        },
        onError: (error) => const SizedBox.shrink(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_outlined),
        onPressed: () => context.pushRoute(
          AddAddressRoute(),
        ),
      ),
    );
  }
}
