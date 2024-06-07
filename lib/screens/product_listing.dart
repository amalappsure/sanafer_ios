import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/cart/presentation/cart_action.dart';
import 'package:base_ecom_appsure/features/home/models/category.dart';
import 'package:base_ecom_appsure/features/products/models/product.dart';
import 'package:base_ecom_appsure/features/products/models/product_panels.dart';
import 'package:base_ecom_appsure/features/products/presentation/choosers.dart';
import 'package:base_ecom_appsure/features/products/presentation/list_grid_chooser.dart';
import 'package:base_ecom_appsure/features/products/presentation/product_item_base/product_item_base.dart';
import 'package:base_ecom_appsure/features/products/providers/products_list_provider.dart';
import 'package:base_ecom_appsure/foundation/add_to_cart_anim_controller.dart';
import 'package:base_ecom_appsure/themes/shadows.dart';
import 'package:base_ecom_appsure/widgets/choose_language_action.dart';
import 'package:base_ecom_appsure/widgets/responsive_builder.dart';
import 'package:base_ecom_appsure/widgets/search_action.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/screens/search_products.dart';
import 'package:sanafer/widgets/custom_add_to_cart_animation.dart';

@RoutePage()
class ProductsListingScreen extends ConsumerStatefulWidget {
  const ProductsListingScreen({
    super.key,
    this.category,
    this.parentCategories = const [],
    this.productPanel,
    this.searchQuery,
  });

  final Category? category;
  final List<Category> parentCategories;
  final ProductPanel? productPanel;
  final String? searchQuery;

  @override
  ConsumerState<ProductsListingScreen> createState() =>
      _ProductsListingScreenState();
}

class _ProductsListingScreenState extends ConsumerState<ProductsListingScreen> {
  final _cartKey = GlobalKey<CartIconKey>();
  final AddToCartAnimController _animationController =
  AddToCartAnimController();

  late String _family;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        _loadData();
        provider.setCategory(widget.category, notify: false);
      },
    );

    String path = context.router.currentPath;
    if (widget.searchQuery != null) {
      path += widget.searchQuery!;
    } else if (widget.productPanel != null) {
      path += widget.productPanel!.title;
    } else if (widget.category != null) {
      path += widget.category!.title;
    }

    _family = '$path-${DateTime.now().toIso8601String()}';

    provider.panel = widget.productPanel;
    provider.searchQuery = widget.searchQuery;

    super.initState();
  }

  void _loadData() {
    provider.getSortMethods();
    provider.getFilterCategoryListByID();
  }

  String get family => _family;

  CategoryProductsProvider get provider => ref.read(
    productListProvider(family),
  );

  @override
  Widget build(BuildContext context) {
    ref.watch(productListProvider(family));
    final settings = ref.watch(settingsProvider);
    final title = provider.title;
    _initListeners();
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return CustomAddToCartAnimation(
      cartKey: _cartKey,
      animationController: _animationController,
      child: Scaffold(
        body: provider.sortBy == null
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => context.popRoute(),
                child: Icon(
                  isRtl ? Iconsax.arrow_right_1 : Iconsax.arrow_left,color: Colors.black,
                ),
              ),
              floating: true,
              pinned: true,
              // title: Text(widget.category.title),
              actions: [
                SearchAction(
                  color: true,
                  onPressed: () => SearchProductsDialog.show(context),
                ),
                CartAction(
                  cartKey: _cartKey,
                  onPressed: () {
                    context.router.removeWhere(
                          (route) => route.name == CartRoute.name,
                    );
                    context.pushRoute(const CartRoute());
                  },
                  color: true,
                ),
                const ChooseLanguageAction(color: true,)
              ],
            ),
            SliverPinnedHeader(
              child: Container(
                height: 60.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [shadow1],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListGridChooser(family: family),
                      const Gap(8),
                      SortMethodChooser(family: family),
                      const Gap(8),
                      CategoryChooser(
                        family: family,
                        categories: widget.parentCategories,
                      ),
                      const Gap(8),
                      PriceChooser(family: family),
                      const Gap(8),
                      // AvailabilityChooser(family: family),
                    ],
                  ),
                ),
              ),
            ),
            if (title != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    settings.selectedLocale!.translate(title),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
          ],
          body: RefreshIndicator(
            onRefresh: () async => provider.pagingController.refresh(),
            child: provider.listView ? _list : _grid,
          ),
        ),
      ),
    );
  }

  Widget get _grid {
    return PagedMasonryGridView.count(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 2.0,
      ).copyWith(
        top: 0.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      pagingController: provider.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Product>(
        itemBuilder: (context, item, index) {
          final extraHeight = item.endDate != null;
          return Responsive(
            mobile: (_, constraints, child) => SizedBox(
              height: MediaQuery.of(context).size.width *
                  (extraHeight ? 0.8 : 0.8),
              child: child,
            ),
            smallTablet: (_, constraints, child) => SizedBox(
              height: MediaQuery.of(context).size.width * 0.6,
              child: child,
            ),
            mediumTablet: (_, constraints, child) => SizedBox(
              height: MediaQuery.of(context).size.width * 0.45,
              child: child,
            ),
            desktop: (context, constraints, child) => SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              child: child,
            ),
            child: ProductBase.panel(
              product: item,
              onTap: () => context.pushRoute(
                ProductDetailsRoute(
                  productId: item.itemId,
                  unitId: item.unitId,
                ),
              ),
              width: (MediaQuery.of(context).size.width / 2) - 12,
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
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) => _gridShimmer,
      ),
      crossAxisCount: 2,
    );
  }

  Widget get _gridShimmer {
    return ListView(
      padding: const EdgeInsets.all(5).copyWith(
        top: 0.0,
      ),
      children: List.generate(
        2,
            (index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            2,
                (index) => Responsive(
              mobile: (_, constraints, child) => SizedBox(
                height: MediaQuery.of(context).size.width * 0.9,
                child: child,
              ),
              smallTablet: (_, constraints, child) => SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                child: child,
              ),
              mediumTablet: (_, constraints, child) => SizedBox(
                height: MediaQuery.of(context).size.width * 0.45,
                child: child,
              ),
              desktop: (context, constraints, child) => SizedBox(
                height: MediaQuery.of(context).size.height / 2.4,
                child: child,
              ),
              child: PanelProductShimmer(
                width: MediaQuery.of(context).size.width * 0.45,
                verticalMargin: 6.0,
                horizontalMargin: 6.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _list {
    return PagedListView(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ).copyWith(
        top: 0.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      pagingController: provider.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Product>(
        itemBuilder: (context, item, index) => ProductBase.list(
          onTap: () => context.pushRoute(
            ProductDetailsRoute(
              productId: item.itemId,
              unitId: item.unitId,
            ),
          ),
          product: item,
          globalKey: GlobalKey(),
          errorImage: DecorationImage(
            image: Assets.images.sanaferlogo.provider(),
          ),
          runCartingAnim: (globalKey) async {
            if (globalKey != null) {
              await _animationController.run(globalKey);
              await _cartKey.currentState!.runCartAnimation('0');
            }
          },
        ),
        firstPageProgressIndicatorBuilder: (context) => _listShimmer,
      ),
    );
  }

  Widget get _listShimmer {
    return Column(
      children: List.generate(
        6,
            (index) => const ProductListItemShimmer(),
      ),
    );
  }

  void _initListeners() {
    ref.listen(sortMethodsProvider(family), (previous, next) {
      if (next.isSuccess && provider.sortBy == null) {
        provider.sortBy = next.data!.firstOrNull;
        setState(() {});
      }
    });
  }
}
