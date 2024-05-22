import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/cart/providers/cart_provider.dart';
import 'package:base_ecom_appsure/features/checkout/presentation/checkout_view/checkout_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return PopScope(
      onPopInvoked: (didPop) {
        if (!didPop) {
          ref.read(cartProvider).clearQuickBuy();
          Navigator.pop(context);
        }
      },
      canPop: false,
      child: Scaffold(
        appBar: AlSanaferAppBar(
          title: settings.selectedLocale!.translate(
            'Checkout',
          ),
          // showActions: ,
          showCart: false,
          showSearch: false,
        ),
        body: CheckoutView(
          pushWebView: (webViewController, [others]) => context.pushRoute(
            WebViewRoute(controller: webViewController),
          ),
          pushAddAddress: (address, [__]) => context.pushRoute(
            AddAddressRoute(address: address),
          ),
          onOrderSuccess: (isSuccess, [others]) {
            if (isSuccess) {
              ref.read(cartProvider).loadCartFromRemote();
            }
            final result = context.router.pushAndPopUntil(
              OrderPlacedRoute(
                items: [...ref.read(cartProvider).items],
                failed: !isSuccess,
                paymentMethod: others![1],
                deliveryAddress: others[0],
                total: others[2],
              ),
              predicate: (route) {
                if (isSuccess && route.data?.name != HomeRoute.name) {
                  return false;
                } else if (!isSuccess &&
                    route.data?.name != CheckoutRoute.name) {
                  return false;
                }

                return true;
              },
            );

            return result;
          },
          onItemTapped: (value) => context.popRoute().then(
                (_) => context.pushRoute(
              ProductDetailsRoute(
                productId: value.itemId,
                unitId: value.unitId,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
