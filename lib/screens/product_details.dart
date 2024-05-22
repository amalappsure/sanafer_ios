import 'dart:async';
import 'dart:math';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/app_config_provider.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/cart/presentation/add_to_cart_button.dart';
import 'package:base_ecom_appsure/features/cart/providers/cart_provider.dart';
import 'package:base_ecom_appsure/features/products/models/product_details/product_details.dart';
import 'package:base_ecom_appsure/features/products/presentation/bottom_sheets/product_zoom.dart';
import 'package:base_ecom_appsure/features/products/presentation/count_downer.dart';
import 'package:base_ecom_appsure/features/products/presentation/product_details/product_details_payment_delivery_info.dart';
import 'package:base_ecom_appsure/features/products/presentation/product_images_array.dart';
import 'package:base_ecom_appsure/features/products/presentation/product_item_base/product_item_base.dart';
import 'package:base_ecom_appsure/features/products/presentation/product_item_base/product_rating.dart';
import 'package:base_ecom_appsure/features/products/presentation/product_panels/product_panels.dart';
import 'package:base_ecom_appsure/features/products/presentation/stock_status.dart';
import 'package:base_ecom_appsure/features/products/providers/product_details_provider.dart';
import 'package:base_ecom_appsure/features/reviews/models/reviews_list/rating.dart';
import 'package:base_ecom_appsure/features/reviews/presentation/product_details_ratings_and_reviews.dart';
import 'package:base_ecom_appsure/features/reviews/providers/reviews_provider.dart';
import 'package:base_ecom_appsure/features/wishlist/presentation/product_heart.dart';
import 'package:base_ecom_appsure/foundation/add_to_cart_anim_controller.dart';
import 'package:base_ecom_appsure/widgets/custom_drop_down.dart';
import 'package:base_ecom_appsure/widgets/whats_app_launcher.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';
import 'package:sanafer/widgets/custom_add_to_cart_animation.dart';

@RoutePage()
class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.unitId,
  });

  final int productId;
  final int unitId;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      ProductDetailsScreenState();
}

class ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  ProductImagesController imagesController = ProductImagesController();
  AppSettingsprovider get _settings => ref.read(settingsProvider);
  CartProvider get cart => ref.read(cartProvider);
  AppConfig get appConfig => ref.read(appConfigProvider);
  int count = 1;

  ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics();

  final _cartKey = GlobalKey<CartIconKey>();
  final AddToCartAnimController _animationController =
  AddToCartAnimController();

  late StreamController<Rating> _reviewsController;

  @override
  void initState() {
    _reviewsController = StreamController<Rating>.broadcast();
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => _loadData(),
    );

    super.initState();
  }

  @override
  void dispose() {
    _reviewsController.close();
    super.dispose();
  }

  void _loadData() async {
    ref
        .read(productDetailsController(widget.productId))
        .getProductDetails(widget.productId, unitId: widget.unitId);

    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      final data = await ref.read(reviewsProvider).getReviewsByItemID(
        widget.productId,
      );
      if (!_reviewsController.isClosed) {
        _reviewsController.add(data);
      }
    } catch (error) {
      if (!_reviewsController.isClosed) {
        _reviewsController.addError(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    ref.watch(cartProvider);
    ref.listen(cartProvider, (_, __) {});
    ref.listen(settingsProvider, (previous, next) => _loadData());
    return CustomAddToCartAnimation(
      cartKey: _cartKey,
      animationController: _animationController,
      child: Scaffold(
        appBar: AlSanaferAppBar(
          backgroundColor: true,
          cartKey: _cartKey,
        ),
        body: ref.watch(productDetailsProvider(widget.productId)).when(
          onLoading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          onSuccess: (details) {
            final maxDropDownValue = _maxDropDownValue(
              details,
              appConfig.sellOutOfStock,
            );
            count = maxDropDownValue > 0 && count < 1
                ? 1
                : maxDropDownValue < 1
                ? 0
                : count > maxDropDownValue
                ? 1
                : count;
            return SingleChildScrollView(
              physics: scrollPhysics,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductImagesArray(
                    onInteractionStart: (details) => setState(() {
                      scrollPhysics = const NeverScrollableScrollPhysics();
                    }),
                    onInteractionEnd: (details) => setState(() {
                      scrollPhysics = const AlwaysScrollableScrollPhysics();
                    }),
                    images: details.itemImages,
                    controller: imagesController,
                    errorImagePath: Assets.images.noImage.path,
                    buttons: [
                      WhatsAppLauncher(
                        itemName: details.itemName ?? '',
                        urlName: details.urlName ?? '',
                        unitId: details.unitId,
                      ),
                      const Gap(8.0),
                      ProductHeart(
                        productId: details.id,
                        unitId: details.unitId,
                      ),
                    ],
                    slidIcon: SizedBox(
                      child: GestureDetector(
                          onTap: (){
                            if (!appConfig.enableImageMagnificationInDetailPage) {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                enableDrag: false,
                                isScrollControlled: true,
                                builder: (context) => ProductZoomBS(
                                  images: details.itemImages,
                                  initialIndex: 0,
                                  errorImagePath: Assets.images.noImage.path,
                                ),
                              );
                            }
                          },
                          child: const Icon(Icons.photo_library_outlined)),
                    ),
                    onImageClicked: (value) {
                      if (appConfig.enableImageMagnificationInDetailPage) {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          enableDrag: false,
                          isScrollControlled: true,
                          builder: (context) => ProductZoomBS(
                            images: details.itemImages,
                            initialIndex: value,
                            errorImagePath: Assets.images.noImage.path,
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          details.itemName ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Gap(8),
                        StreamBuilder(
                          stream: _reviewsController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const SizedBox.shrink();
                            } else if (!snapshot.hasData) {
                              return const SizedBox.shrink();
                            } else {
                              final data = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    ProductRating(
                                      rating: data.average,
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        Text(
                          "${settings.selectedLocale!.translate('ProductNumber')} #${details.itemCode ?? ''}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey.shade500),
                        ),
                        const Gap(4),
                        Text(
                          "${settings.selectedLocale!.translate('ProductCode')} #${details.id}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey.shade500),
                        ),
                        const Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              _settings.priceText(details.currentPrice),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (details.endDate != null) ...[
                              const Gap(16.0),
                              Text(
                                _settings.priceText(details.sellingPrice),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                  decoration:
                                  TextDecoration.lineThrough,
                                  decorationThickness: 2.0,
                                ),
                              )
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (appConfig.sellOutOfStock && details.stock <= 0)
                        const StockStatus(inStock: true)
                      else
                        StockStatus(
                          inStock: details.stock > 0,
                        ),
                    ],
                  ),
                  if (details.endDate != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13.0,
                        vertical: 8.0,
                      ),
                      child: CountDowner(endDate: details.endDate!),
                    ),
                  if (!appConfig.sellOutOfStock && details.stock <= 0)
                    const SizedBox.shrink()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        children: [
                          _dropDown(maxDropDownValue),
                          const Gap(8.0),
                          Row(
                            children: [
                              Expanded(
                                child: _addToCartButton(details),
                              ),
                              if (!appConfig.removeBuyNow) ...[
                                const Gap(8.0),
                                Expanded(
                                  child: _buyNowButton(
                                    count > 0
                                        ? () async {
                                      // if (cart.isNotEmpty) {
                                      //   await cart.clearRemoteCart();
                                      // }

                                      await cart.addToCart(
                                        details.product,
                                        count,
                                      );
                                      cart.setquickBuy(
                                        details.product.unitId,
                                        details.product.itemId,
                                      );
                                      // ignore: use_build_context_synchronously
                                      context.pushRoute(
                                        const CheckoutRoute(),
                                      );
                                    }
                                        : null,
                                  ),
                                )
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: ProductDetailsPaymentDeliveryInfo(
                      details: details,
                      productId: widget.productId,
                    ),
                  ),
                  if (appConfig.enableRatingsAndReviews)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: RatingsAndreviews(productId: widget.productId),
                    ),
                  ref
                      .watch(similarItemsProvider(
                    widget.productId,
                  ))
                      .when(
                    onLoading: () => const PanelShimmer(),
                    onSuccess: (data) => PanelBase.widget(
                      panel: data,
                      extraheight: data.panelProducts
                          .where((element) => element.endDate != null)
                          .toList()
                          .isNotEmpty,
                      panelTitleBuilder: (context, panel) =>
                          PanelTitleBase.widget(
                            panel: panel,
                            translateTitle: true,
                          ),
                      itemBuilder: (context, product, pageLength) =>
                          ProductBase.panel(
                            globalKey: GlobalKey(),
                            product: product,
                            width: (MediaQuery.of(context).size.width /
                                pageLength) -
                                12,
                            runCartingAnim: (globalKey) async {
                              if (globalKey != null) {
                                await _animationController.run(globalKey);
                                await _cartKey.currentState!
                                    .runCartAnimation('0');
                              }
                            },
                            errorImage: DecorationImage(
                              image: Assets.images.sanaferlogo.provider(),
                            ),
                            onTap: () => context.pushRoute(
                              ProductDetailsRoute(
                                productId: product.itemId,
                                unitId: product.unitId,
                              ),
                            ),
                          ),
                    ),
                    onError: (error) => const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          },
          onError: (error) => Center(
            child: Text(
              error.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }

  CustomDropdownButton _dropDown(int maxValue) {
    return CustomDropdownButton<int>(
      key: UniqueKey(),
      hint: _settings.selectedLocale!.translate('Outofstock'),
      items: List.generate(
        maxValue,
            (index) => index + 1,
      ).toList(),
      onChanged: (value) {
        if (value != null) {
          count = value;
        }
      },
      value: count,
    );
  }

  int _maxDropDownValue(ProductDetails details, bool sellOutOfStock) {
    final count = cart.countOf(details.id, details.unitId);
    if (sellOutOfStock && !details.quantityPerCustomerEnabled) {
      return 10;
    } else if (sellOutOfStock) {
      final difference = details.qtyPerCustomer - count;
      return min(details.qtyPerCustomer, min(difference, 10));
    }
    final difference = details.maxAllowedCount - count;
    return min(details.maxAllowedCount, min(difference, 10));
  }

  Widget _addToCartButton(ProductDetails details) {
    return AddToCartButton(
      onPressed: count > 0
          ? () async {
        cart.incrOrDecrItemCount(
          details.product,
          number: count,
        );

        await _animationController.run(
          imagesController.getCurrentKey(),
        );
        await _cartKey.currentState!.runCartAnimation('0');
      }
          : null,
      padding: const EdgeInsets.all(20),
      iconSize: 20,
      gap: 8,
    );
  }

  AddToCartButton _buyNowButton(VoidCallback? onPressed) {
    return AddToCartButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(20),
      icon: FontAwesomeIcons.boltLightning,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      label: _settings.selectedLocale!.translate('BuyNow'),
      iconSize: 20,
      gap: 8,
    );
  }
}
