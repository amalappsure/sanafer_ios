import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/cart/presentation/cart_item.dart';
import 'package:base_ecom_appsure/features/cart/providers/cart_provider.dart';
import 'package:base_ecom_appsure/widgets/default_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class CartTab extends ConsumerWidget {
  const CartTab({
    required this.jumpToHome,
    super.key,
  });

  final VoidCallback jumpToHome;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Assets.svgs.alayshWhite.svg(),
        ),
      ),
      body: cart.items.isNotEmpty
          ? RefreshIndicator.adaptive(
        onRefresh: () => ref.read(cartProvider).loadCartFromRemote(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16).copyWith(
            bottom: 80.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                settings.selectedLocale!.translate('Cart'),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              ListView.builder(
                itemCount: cart.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CartListItemBase.widget(
                  item: cart.items[index],
                  errorImage: DecorationImage(
                    image: Assets.images.sanaferlogo.provider(),
                  ),
                  onTap: () => context.pushRoute(
                    ProductDetailsRoute(
                      productId: cart.items[index].itemId,
                      unitId: cart.items[index].unitId,
                    ),
                  ),
                ),
              ),
              DefaultCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      settings.selectedLocale!.translate('OrderSummary'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${settings.selectedLocale!.translate('SubTotal')} '
                              '(${cart.itemsCount} ${settings.selectedLocale!.translate('items')})',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          cart.cartValueString,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          settings.selectedLocale!.translate('Total'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          cart.cartValueString,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Gap(8),
                    ElevatedButton(
                      onPressed: () {
                        context.router.removeWhere(
                              (route) => route.name == CheckoutRoute.name,
                        );
                        context.pushRoute(const CheckoutRoute());
                      },
                      child: Text(
                        settings.selectedLocale!.translate(
                          'ProceedToBuy',
                        ),
                      ),
                     )
                  ],
                ),
              ),
              _info(
                context,
                settings.selectedLocale!.translate('CartInfo1'),
              ),
              const Gap(4),
              _info(
                context,
                settings.selectedLocale!.translate('CartInfo2'),
              ),
            ],
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              settings.selectedLocale!.translate('Cart'),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            const Icon(
              Iconsax.shopping_cart,
              size: 80,
            ),
            const Gap(16.0),
            Text(
              settings.selectedLocale!.translate(
                'YourShoppingCartisempty',
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(8.0),
            Text(
              settings.selectedLocale!.translate(
                'Additemstoitnow',
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(16.0),
            Center(
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                  ),
                  onPressed: jumpToHome,
                  child: Text(
                    settings.selectedLocale!.translate(
                      'Shopnow',
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Text _info(BuildContext context, String info) {
    return Text(
      info,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
