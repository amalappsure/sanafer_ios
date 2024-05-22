import 'package:base_ecom_appsure/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';

import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/screens/search_products.dart';

class AlSanaferAppBar extends CustomAppBar {
  const AlSanaferAppBar({
    super.key,
    super.title,
    super.leading,
    super.showActions = true,
    super.showSearch,
    super.cartKey,
    super.showCart,
    super.backgroundColor,
  });

  @override
  void onLeadingClicked(context, ref) => context.popRoute();

  @override
  void onSearchClicked(context, ref) => SearchProductsDialog.show(context);

  @override
  void onCartClicked(context, ref) {
    context.router.removeWhere(
          (route) => route.name == CartRoute.name,
    );
    context.pushRoute(const CartRoute());
  }
}
