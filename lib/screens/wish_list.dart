import "package:base_ecom_appsure/widgets/responsive_builder.dart";
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/wishlist/presentation/wish_list_item.dart';
import 'package:base_ecom_appsure/features/wishlist/providers/wish_list_provider.dart';
import 'package:base_ecom_appsure/foundation/add_to_cart_anim_controller.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/providers/home_context_provider.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';
import 'package:sanafer/widgets/custom_add_to_cart_animation.dart';

@RoutePage()
class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  final _cartKey = GlobalKey<CartIconKey>();
  final AddToCartAnimController _animationController =
  AddToCartAnimController();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(wishListProvider);
    final settings = ref.watch(settingsProvider);
    return CustomAddToCartAnimation(
      cartKey: _cartKey,
      animationController: _animationController,
      child: Scaffold(
        appBar: AlSanaferAppBar(
          cartKey: _cartKey,
          title: settings.selectedLocale!.translate('YourWishList'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.valueWhen(
              context: context,
              mobile: 0.0,
              smallTablet: 0.0,
              mediumTablet: MediaQuery.of(context).size.width * 0.1,
              largeTablet: MediaQuery.of(context).size.width * 0.2,
              desktop: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          child: provider.listState.when<Widget>(
            onLoading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            onSuccess: (wishList) {
              if (wishList.isEmpty) {
                return Padding(
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
                          'YourWishlistisempty',
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
                );
              }
              return RefreshIndicator.adaptive(
                onRefresh: () => provider.getWishlistItemsList(),
                child: ListView.builder(
                  itemCount: wishList.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) => WishListItemBase.widget(
                    item: wishList[index],
                    errorImage: DecorationImage(
                      image: Assets.images.sanaferlogo.provider(),
                    ),
                    globalKey: GlobalKey(),
                    runCartingAnim: (globalKey) async {
                      if (globalKey != null) {
                        await _animationController.run(globalKey);
                        await _cartKey.currentState!.runCartAnimation('0');
                      }
                    },
                    onTap: () => context.pushRoute(
                      ProductDetailsRoute(
                        productId: wishList[index].itemId,
                        unitId: wishList[index].unitId,
                      ),
                    ),
                    onRemoveClicked: () =>
                        ref.read(wishListProvider).removeWishlistItem(
                          wishList[index].id,
                        ),
                  ),
                ),
              );
            },
            onError: (error) => _message(error.toString()),
          ),
        ),
      ),
    );
  }

  Widget _message(String message) => Padding(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    ),
  );
}
