import "package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart";
import "package:base_ecom_appsure/features/products/presentation/product_panels/product_panels.dart";
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/app_config_provider.dart';
import 'package:base_ecom_appsure/features/home/models/category.dart';
import 'package:base_ecom_appsure/features/home/presentation/banners.dart';
import 'package:base_ecom_appsure/features/home/presentation/categories/categories.dart';
import 'package:base_ecom_appsure/features/home/providers/category_size_provider.dart';
import 'package:base_ecom_appsure/features/products/presentation/product_item_base/product_item_base.dart';
import 'package:base_ecom_appsure/foundation/add_to_cart_anim_controller.dart';
import 'package:base_ecom_appsure/foundation/refresh_controller.dart';
import 'package:base_ecom_appsure/widgets/text_field.dart';
import 'package:sanafer/screens/search_products.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';
import 'package:sanafer/widgets/custom_add_to_cart_animation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab>
    with AutomaticKeepAliveClientMixin {
  final panelsRefresher = RefreshController();
  final categoriesRefresher = RefreshController();
  final bannersRefresher = RefreshController();

  AppConfig get _appConfig => ref.read(appConfigProvider);

  final _cartKey = GlobalKey<CartIconKey>();
  final AddToCartAnimController _animationController =
  AddToCartAnimController();

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    super.build(context);
    return CustomAddToCartAnimation(
      cartKey: _cartKey,
      animationController: _animationController,
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverPinnedHeader(
                child: AlSanaferAppBar(
                  cartKey: _cartKey,
                  showSearch: false,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Assets.images.sanaferlogo.image(),
                  ),
                ),
              ),
              SliverPinnedHeader(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.068,
                  color: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 8),
                  child: CustomTextFieldBase.widget(
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Iconsax.search_normal_1),
                    readOnly: true,
                    hint: settings.selectedLocale!.translate('Search'),
                    onTap: () => SearchProductsDialog.show(context),
                  ),
                ),
              ),
            ],
            body: RefreshIndicator.adaptive(
              onRefresh: () async {
                panelsRefresher.refresh();
                categoriesRefresher.refresh();
                bannersRefresher.refresh();
              },
              color: Theme.of(context).colorScheme.primary,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (!ref.read(appConfigProvider).enableSlidingCategory)BannersBase.widget(
                      refreshController: bannersRefresher,
                      errorImage: DecorationImage(
                        image: Assets.images.sanaferlogo.provider(),
                      ),
                      onBannerTap: (value, type) {
                        if (type == 'Category' && value != null) {
                          context.pushRoute(ProductsListingRoute(
                            category: Category(id: int.parse(value), title: ''),
                          ));
                        }
                      },
                    ),
                    const Gap(4),
                    // if (_appConfig.showCategoryComponent &&
                    //     _appConfig.showCategoryBoxTypeComponent)
                      CategoriesBase.basedOnSetting(
                        height: ref.read(categorySizeProvider).height(context),
                        itemWidth:
                        ref.read(categorySizeProvider).width(context),
                        refreshController: categoriesRefresher,
                        ref: ref,
                        itemBuilder: ({
                          required category,
                          required context,
                          required height,
                          required width,
                        }) =>
                            CategoryItemBase.widget(
                              height: height,
                              width: width,
                              category: category,
                              errorImage: DecorationImage(
                                  image: Assets.images.sanaferlogo.provider()),
                              onTap: (haveChildren) {
                                if (haveChildren) {
                                  context.pushRoute(SubcategoriesRoute(
                                    category: category,
                                    backTitle: "Home",
                                  ));
                                } else {
                                  context.pushRoute(ProductsListingRoute(
                                    category: category,
                                  ));
                                }
                              },
                            ),
                      ),
                    const Gap(4),
                    if (ref.read(appConfigProvider).enableSlidingCategory)BannersBase.widget(
                      refreshController: bannersRefresher,
                      errorImage: DecorationImage(
                        image: Assets.images.sanaferlogo.provider(),
                      ),
                      onBannerTap: (value, type) {
                        if (type == 'Category' && value != null) {
                          context.pushRoute(ProductsListingRoute(
                            category: Category(id: int.parse(value), title: ''),
                          ));
                        }
                      },
                    ),
                    const Gap(4),
                    PanelsBase.widget(
                      refreshController: panelsRefresher,
                      panelTitleBuilder: (context, panel) =>
                          PanelTitleBase.widget(
                            panel: panel,
                            onPressed: () => context.pushRoute(
                              ProductsListingRoute(productPanel: panel),
                            ),
                          ),
                      itemBuilder: (context, product, pageLength) {
                        double width =
                            (MediaQuery.of(context).size.width / pageLength) -
                                12;

                        if (!_appConfig.enableTwoItemInMobileCarousel) {
                          width = ((MediaQuery.of(context).size.width /
                              pageLength) *
                              0.55) -
                              12;
                        }
                        return ProductBase.panel(
                          globalKey: GlobalKey(),
                          product: product,
                          verticalMargin: 14,
                          runCartingAnim: (globalKey) async {
                            if (globalKey != null) {
                              await _animationController.run(globalKey);
                              await _cartKey.currentState!
                                  .runCartAnimation('0');
                            }
                          },
                          width: width,
                          errorImage: DecorationImage(
                            image: Assets.images.sanaferlogo.provider(),
                          ),
                          onTap: () => context.pushRoute(
                            ProductDetailsRoute(
                              productId: product.itemId,
                              unitId: product.unitId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
