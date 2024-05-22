import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@RoutePage()
class HomeEmptyScreen extends AutoRouter {
  const HomeEmptyScreen({super.key});
}

@RoutePage()
class CategoriesEmptyScreen extends AutoRouter {
  const CategoriesEmptyScreen({super.key});
}

@RoutePage()
class CartEmptyScreen extends AutoRouter {
  const CartEmptyScreen({super.key});
}

@RoutePage()
class AlertsEmptyScreen extends AutoRouter {
  const AlertsEmptyScreen({super.key});
}

@RoutePage()
class AccountsEmptyScreen extends AutoRouter {
  const AccountsEmptyScreen({super.key});
}

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
        path: '/',
        page: DailyPasswordRoute.page,
      initial: true,
    ),
    AutoRoute(
      page: HomeRoute.page,
      children: [
        AutoRoute(
          path: 'home',
          page: HomeEmptyRoute.page,
          children: [
            AutoRoute(page: HomeTab.page, initial: true),
            AutoRoute(page: SubcategoriesRoute.page),
            AutoRoute(page: ProductsListingRoute.page),
            AutoRoute(page: ProductDetailsRoute.page),
            AutoRoute(page: CartRoute.page),
          ],
        ),
        AutoRoute(
          path: 'categories',
          page: CategoriesEmptyRoute.page,
          children: [
            AutoRoute(page: CategoriesTab.page, initial: true),
            AutoRoute(page: SubcategoriesRoute.page),
            AutoRoute(page: ProductsListingRoute.page),
            AutoRoute(page: ProductDetailsRoute.page),
            AutoRoute(page: CartRoute.page),
          ],
        ),
        // AutoRoute(
        //   path: 'alerts',
        //   page: AlertsEmptyRoute.page,
        //   children: [
        //     AutoRoute(page: AlertsTab.page, initial: true),
        //   ],
        // ),
        // AutoRoute(
        //   path: 'cart',
        //   page: CartEmptyRoute.page,
        //   children: [
        //     AutoRoute(page: CartTab.page, initial: true),
        //     AutoRoute(page: ProductDetailsRoute.page),
        //     AutoRoute(page: ProductsListingRoute.page),
        //   ],
        // ),
        AutoRoute(
          path: 'account',
          page: AccountsEmptyRoute.page,
          children: [
            AutoRoute(page: AccountTab.page, initial: true),
            AutoRoute(page: OrdersRoute.page),
            AutoRoute(page: WishListRoute.page),
            AutoRoute(page: AddressesRoute.page),
            AutoRoute(page: ProductDetailsRoute.page),
            AutoRoute(page: TrackOrderRoute.page),
            AutoRoute(page: ProductsListingRoute.page),
            AutoRoute(page: EditProfileRoute.page),
            AutoRoute(page: EditEmailRoute.page),
            AutoRoute(page: CartRoute.page),
          ],
        ),
      ],
    ),
    AutoRoute(page: RegistrationRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: CompanyInfoRoute.page),
    AutoRoute(page: AddAddressRoute.page),
    AutoRoute(page: CheckoutRoute.page),
    AutoRoute(page: WebViewRoute.page),
    AutoRoute(page: OrderPlacedRoute.page),
  ];
}
