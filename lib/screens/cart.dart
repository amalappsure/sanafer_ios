import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/cart/presentation/cart_item.dart';
import 'package:base_ecom_appsure/features/cart/providers/cart_provider.dart';
import 'package:base_ecom_appsure/widgets/default_card.dart';
import 'package:sanafer/providers/home_context_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    final cart = ref.read(cartProvider);
    FirebaseAnalytics.instance.logViewCart(
      currency: 'KWD',
      value: cart.cartValue.toDouble(),
      items: cart.items.map((e) => e.analyticsEventItem).toList(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AlSanaferAppBar(
        title: settings.selectedLocale!.translate('Cart'),
        showCart: false,
        showSearch: false,
        showActions: true,
      ),
      body: cart.items.isNotEmpty
          ? RefreshIndicator.adaptive(
        onRefresh: () => ref.read(cartProvider).loadCartFromRemote(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0).copyWith(
            bottom: 80.0,
          ),
          child: Column(
            children: [
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
                        // context.pushRoute(
                        //   OrderPlacedRoute(
                        //     items: cart.items,
                        //     failed: false,
                        //   ),
                        // );
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
            Assets.images.cartEmpty.image(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            const Gap(16.0),
            Text(
              settings.selectedLocale!.translate(
                'YourShoppingCartisempty',
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(8),
            Text(
              settings.selectedLocale!.translate(
                'Additemstoitnow',
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(16),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3,
              ),
              child: ElevatedButton(
                onPressed: () {
                  final contextsState =
                      ref.read(homeContextProvider.notifier).state;

                  if (contextsState != null) {
                    contextsState.context.router.popForced();
                    contextsState.context.router.push(
                      const HomeRoute(),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  settings.selectedLocale!.translate('Shopnow'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _info(BuildContext context, String info) => Text(
    info,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Theme.of(context).colorScheme.tertiary,
    ),
    textAlign: TextAlign.center,
  );
}
