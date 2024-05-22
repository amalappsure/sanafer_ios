// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:base_ecom_appsure/features/addresses/models/address.dart'
    as _i29;
import 'package:base_ecom_appsure/features/cart/models/cart_item.dart' as _i31;
import 'package:base_ecom_appsure/features/company_info/models/company_info.dart'
    as _i30;
import 'package:base_ecom_appsure/features/home/models/category.dart' as _i33;
import 'package:base_ecom_appsure/features/orders/models/orders_list/order.dart'
    as _i36;
import 'package:base_ecom_appsure/features/orders/models/orders_list/order_item.dart'
    as _i35;
import 'package:base_ecom_appsure/features/products/models/payment_methods.dart'
    as _i32;
import 'package:base_ecom_appsure/features/products/models/product_panels.dart'
    as _i34;
import 'package:flutter/material.dart' as _i28;
import 'package:sanafer/routes/app_router.dart' as _i2;
import 'package:sanafer/screens/add_address.dart' as _i3;
import 'package:sanafer/screens/adresses.dart' as _i4;
import 'package:sanafer/screens/authentication/registration.dart' as _i20;
import 'package:sanafer/screens/cart.dart' as _i6;
import 'package:sanafer/screens/checkout.dart' as _i9;
import 'package:sanafer/screens/company_info.dart' as _i10;
import 'package:sanafer/screens/daily_password.dart' as _i11;
import 'package:sanafer/screens/edit_profile/edit_email.dart' as _i12;
import 'package:sanafer/screens/edit_profile/edit_profile.dart' as _i13;
import 'package:sanafer/screens/home/account_tab.dart' as _i1;
import 'package:sanafer/screens/home/alerts_tab.dart' as _i5;
import 'package:sanafer/screens/home/cart_tab.dart' as _i7;
import 'package:sanafer/screens/home/categories_tab.dart' as _i8;
import 'package:sanafer/screens/home/home_screen.dart' as _i14;
import 'package:sanafer/screens/home/home_tab.dart' as _i15;
import 'package:sanafer/screens/order_placed.dart' as _i16;
import 'package:sanafer/screens/orders.dart' as _i17;
import 'package:sanafer/screens/product_details.dart' as _i18;
import 'package:sanafer/screens/product_listing.dart' as _i19;
import 'package:sanafer/screens/reset_password.dart' as _i21;
import 'package:sanafer/screens/subcategories.dart' as _i22;
import 'package:sanafer/screens/track_order.dart' as _i23;
import 'package:sanafer/screens/under_maintenance.dart' as _i24;
import 'package:sanafer/screens/web_view.dart' as _i25;
import 'package:sanafer/screens/wish_list.dart' as _i26;
import 'package:webview_flutter/webview_flutter.dart' as _i37;

abstract class $AppRouter extends _i27.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i27.PageFactory> pagesMap = {
    AccountTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AccountTab(),
      );
    },
    AccountsEmptyRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AccountsEmptyScreen(),
      );
    },
    AddAddressRoute.name: (routeData) {
      final args = routeData.argsAs<AddAddressRouteArgs>(
          orElse: () => const AddAddressRouteArgs());
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.AddAddressScreen(
          key: args.key,
          address: args.address,
        ),
      );
    },
    AddressesRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AddressesScreen(),
      );
    },
    AlertsEmptyRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AlertsEmptyScreen(),
      );
    },
    AlertsTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.AlertsTab(),
      );
    },
    CartEmptyRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CartEmptyScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CartScreen(),
      );
    },
    CartTab.name: (routeData) {
      final args = routeData.argsAs<CartTabArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.CartTab(
          jumpToHome: args.jumpToHome,
          key: args.key,
        ),
      );
    },
    CategoriesEmptyRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CategoriesEmptyScreen(),
      );
    },
    CategoriesTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.CategoriesTab(),
      );
    },
    CheckoutRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CheckoutScreen(),
      );
    },
    CompanyInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CompanyInfoRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.CompanyInfoScreen(
          key: args.key,
          type: args.type,
        ),
      );
    },
    DailyPasswordRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.DailyPasswordScreen(),
      );
    },
    EditEmailRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.EditEmailScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.EditProfileScreen(),
      );
    },
    HomeEmptyRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeEmptyScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.HomeScreen(),
      );
    },
    HomeTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.HomeTab(),
      );
    },
    OrderPlacedRoute.name: (routeData) {
      final args = routeData.argsAs<OrderPlacedRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.OrderPlacedScreen(
          key: args.key,
          items: args.items,
          failed: args.failed,
          deliveryAddress: args.deliveryAddress,
          paymentMethod: args.paymentMethod,
          total: args.total,
        ),
      );
    },
    OrdersRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.OrdersScreen(),
      );
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.ProductDetailsScreen(
          key: args.key,
          productId: args.productId,
          unitId: args.unitId,
        ),
      );
    },
    ProductsListingRoute.name: (routeData) {
      final args = routeData.argsAs<ProductsListingRouteArgs>(
          orElse: () => const ProductsListingRouteArgs());
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.ProductsListingScreen(
          key: args.key,
          category: args.category,
          parentCategories: args.parentCategories,
          productPanel: args.productPanel,
          searchQuery: args.searchQuery,
        ),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.RegistrationScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.ResetPasswordScreen(),
      );
    },
    SubcategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<SubcategoriesRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.SubcategoriesScreen(
          key: args.key,
          category: args.category,
          parents: args.parents,
          backTitle: args.backTitle,
        ),
      );
    },
    TrackOrderRoute.name: (routeData) {
      final args = routeData.argsAs<TrackOrderRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.TrackOrderScreen(
          key: args.key,
          vId: args.vId,
          vNo: args.vNo,
          items: args.items,
          order: args.order,
        ),
      );
    },
    UnderMaintenanceRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.UnderMaintenanceScreen(),
      );
    },
    WebViewRoute.name: (routeData) {
      final args = routeData.argsAs<WebViewRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WebViewScreen(
          key: args.key,
          controller: args.controller,
        ),
      );
    },
    WishListRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.WishListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AccountTab]
class AccountTab extends _i27.PageRouteInfo<void> {
  const AccountTab({List<_i27.PageRouteInfo>? children})
      : super(
          AccountTab.name,
          initialChildren: children,
        );

  static const String name = 'AccountTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountsEmptyScreen]
class AccountsEmptyRoute extends _i27.PageRouteInfo<void> {
  const AccountsEmptyRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AccountsEmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountsEmptyRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddAddressScreen]
class AddAddressRoute extends _i27.PageRouteInfo<AddAddressRouteArgs> {
  AddAddressRoute({
    _i28.Key? key,
    _i29.Address? address,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          AddAddressRoute.name,
          args: AddAddressRouteArgs(
            key: key,
            address: address,
          ),
          initialChildren: children,
        );

  static const String name = 'AddAddressRoute';

  static const _i27.PageInfo<AddAddressRouteArgs> page =
      _i27.PageInfo<AddAddressRouteArgs>(name);
}

class AddAddressRouteArgs {
  const AddAddressRouteArgs({
    this.key,
    this.address,
  });

  final _i28.Key? key;

  final _i29.Address? address;

  @override
  String toString() {
    return 'AddAddressRouteArgs{key: $key, address: $address}';
  }
}

/// generated route for
/// [_i4.AddressesScreen]
class AddressesRoute extends _i27.PageRouteInfo<void> {
  const AddressesRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AddressesRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressesRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AlertsEmptyScreen]
class AlertsEmptyRoute extends _i27.PageRouteInfo<void> {
  const AlertsEmptyRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AlertsEmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'AlertsEmptyRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i5.AlertsTab]
class AlertsTab extends _i27.PageRouteInfo<void> {
  const AlertsTab({List<_i27.PageRouteInfo>? children})
      : super(
          AlertsTab.name,
          initialChildren: children,
        );

  static const String name = 'AlertsTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CartEmptyScreen]
class CartEmptyRoute extends _i27.PageRouteInfo<void> {
  const CartEmptyRoute({List<_i27.PageRouteInfo>? children})
      : super(
          CartEmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartEmptyRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CartScreen]
class CartRoute extends _i27.PageRouteInfo<void> {
  const CartRoute({List<_i27.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CartTab]
class CartTab extends _i27.PageRouteInfo<CartTabArgs> {
  CartTab({
    required void Function() jumpToHome,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          CartTab.name,
          args: CartTabArgs(
            jumpToHome: jumpToHome,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CartTab';

  static const _i27.PageInfo<CartTabArgs> page =
      _i27.PageInfo<CartTabArgs>(name);
}

class CartTabArgs {
  const CartTabArgs({
    required this.jumpToHome,
    this.key,
  });

  final void Function() jumpToHome;

  final _i28.Key? key;

  @override
  String toString() {
    return 'CartTabArgs{jumpToHome: $jumpToHome, key: $key}';
  }
}

/// generated route for
/// [_i2.CategoriesEmptyScreen]
class CategoriesEmptyRoute extends _i27.PageRouteInfo<void> {
  const CategoriesEmptyRoute({List<_i27.PageRouteInfo>? children})
      : super(
          CategoriesEmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesEmptyRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i8.CategoriesTab]
class CategoriesTab extends _i27.PageRouteInfo<void> {
  const CategoriesTab({List<_i27.PageRouteInfo>? children})
      : super(
          CategoriesTab.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CheckoutScreen]
class CheckoutRoute extends _i27.PageRouteInfo<void> {
  const CheckoutRoute({List<_i27.PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i10.CompanyInfoScreen]
class CompanyInfoRoute extends _i27.PageRouteInfo<CompanyInfoRouteArgs> {
  CompanyInfoRoute({
    _i28.Key? key,
    required _i30.InfoType type,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          CompanyInfoRoute.name,
          args: CompanyInfoRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'CompanyInfoRoute';

  static const _i27.PageInfo<CompanyInfoRouteArgs> page =
      _i27.PageInfo<CompanyInfoRouteArgs>(name);
}

class CompanyInfoRouteArgs {
  const CompanyInfoRouteArgs({
    this.key,
    required this.type,
  });

  final _i28.Key? key;

  final _i30.InfoType type;

  @override
  String toString() {
    return 'CompanyInfoRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i11.DailyPasswordScreen]
class DailyPasswordRoute extends _i27.PageRouteInfo<void> {
  const DailyPasswordRoute({List<_i27.PageRouteInfo>? children})
      : super(
          DailyPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'DailyPasswordRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i12.EditEmailScreen]
class EditEmailRoute extends _i27.PageRouteInfo<void> {
  const EditEmailRoute({List<_i27.PageRouteInfo>? children})
      : super(
          EditEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditEmailRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i13.EditProfileScreen]
class EditProfileRoute extends _i27.PageRouteInfo<void> {
  const EditProfileRoute({List<_i27.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeEmptyScreen]
class HomeEmptyRoute extends _i27.PageRouteInfo<void> {
  const HomeEmptyRoute({List<_i27.PageRouteInfo>? children})
      : super(
          HomeEmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeEmptyRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i14.HomeScreen]
class HomeRoute extends _i27.PageRouteInfo<void> {
  const HomeRoute({List<_i27.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i15.HomeTab]
class HomeTab extends _i27.PageRouteInfo<void> {
  const HomeTab({List<_i27.PageRouteInfo>? children})
      : super(
          HomeTab.name,
          initialChildren: children,
        );

  static const String name = 'HomeTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i16.OrderPlacedScreen]
class OrderPlacedRoute extends _i27.PageRouteInfo<OrderPlacedRouteArgs> {
  OrderPlacedRoute({
    _i28.Key? key,
    required List<_i31.CartItem> items,
    bool failed = false,
    _i29.Address? deliveryAddress,
    _i32.PaymentMethod? paymentMethod,
    double? total,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          OrderPlacedRoute.name,
          args: OrderPlacedRouteArgs(
            key: key,
            items: items,
            failed: failed,
            deliveryAddress: deliveryAddress,
            paymentMethod: paymentMethod,
            total: total,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderPlacedRoute';

  static const _i27.PageInfo<OrderPlacedRouteArgs> page =
      _i27.PageInfo<OrderPlacedRouteArgs>(name);
}

class OrderPlacedRouteArgs {
  const OrderPlacedRouteArgs({
    this.key,
    required this.items,
    this.failed = false,
    this.deliveryAddress,
    this.paymentMethod,
    this.total,
  });

  final _i28.Key? key;

  final List<_i31.CartItem> items;

  final bool failed;

  final _i29.Address? deliveryAddress;

  final _i32.PaymentMethod? paymentMethod;

  final double? total;

  @override
  String toString() {
    return 'OrderPlacedRouteArgs{key: $key, items: $items, failed: $failed, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, total: $total}';
  }
}

/// generated route for
/// [_i17.OrdersScreen]
class OrdersRoute extends _i27.PageRouteInfo<void> {
  const OrdersRoute({List<_i27.PageRouteInfo>? children})
      : super(
          OrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ProductDetailsScreen]
class ProductDetailsRoute extends _i27.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i28.Key? key,
    required int productId,
    required int unitId,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            productId: productId,
            unitId: unitId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static const _i27.PageInfo<ProductDetailsRouteArgs> page =
      _i27.PageInfo<ProductDetailsRouteArgs>(name);
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.productId,
    required this.unitId,
  });

  final _i28.Key? key;

  final int productId;

  final int unitId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productId: $productId, unitId: $unitId}';
  }
}

/// generated route for
/// [_i19.ProductsListingScreen]
class ProductsListingRoute
    extends _i27.PageRouteInfo<ProductsListingRouteArgs> {
  ProductsListingRoute({
    _i28.Key? key,
    _i33.Category? category,
    List<_i33.Category> parentCategories = const [],
    _i34.ProductPanel? productPanel,
    String? searchQuery,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          ProductsListingRoute.name,
          args: ProductsListingRouteArgs(
            key: key,
            category: category,
            parentCategories: parentCategories,
            productPanel: productPanel,
            searchQuery: searchQuery,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsListingRoute';

  static const _i27.PageInfo<ProductsListingRouteArgs> page =
      _i27.PageInfo<ProductsListingRouteArgs>(name);
}

class ProductsListingRouteArgs {
  const ProductsListingRouteArgs({
    this.key,
    this.category,
    this.parentCategories = const [],
    this.productPanel,
    this.searchQuery,
  });

  final _i28.Key? key;

  final _i33.Category? category;

  final List<_i33.Category> parentCategories;

  final _i34.ProductPanel? productPanel;

  final String? searchQuery;

  @override
  String toString() {
    return 'ProductsListingRouteArgs{key: $key, category: $category, parentCategories: $parentCategories, productPanel: $productPanel, searchQuery: $searchQuery}';
  }
}

/// generated route for
/// [_i20.RegistrationScreen]
class RegistrationRoute extends _i27.PageRouteInfo<void> {
  const RegistrationRoute({List<_i27.PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i21.ResetPasswordScreen]
class ResetPasswordRoute extends _i27.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i22.SubcategoriesScreen]
class SubcategoriesRoute extends _i27.PageRouteInfo<SubcategoriesRouteArgs> {
  SubcategoriesRoute({
    _i28.Key? key,
    required _i33.Category category,
    List<_i33.Category> parents = const [],
    String? backTitle,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          SubcategoriesRoute.name,
          args: SubcategoriesRouteArgs(
            key: key,
            category: category,
            parents: parents,
            backTitle: backTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'SubcategoriesRoute';

  static const _i27.PageInfo<SubcategoriesRouteArgs> page =
      _i27.PageInfo<SubcategoriesRouteArgs>(name);
}

class SubcategoriesRouteArgs {
  const SubcategoriesRouteArgs({
    this.key,
    required this.category,
    this.parents = const [],
    this.backTitle,
  });

  final _i28.Key? key;

  final _i33.Category category;

  final List<_i33.Category> parents;

  final String? backTitle;

  @override
  String toString() {
    return 'SubcategoriesRouteArgs{key: $key, category: $category, parents: $parents, backTitle: $backTitle}';
  }
}

/// generated route for
/// [_i23.TrackOrderScreen]
class TrackOrderRoute extends _i27.PageRouteInfo<TrackOrderRouteArgs> {
  TrackOrderRoute({
    _i28.Key? key,
    required int vId,
    required String vNo,
    required List<_i35.OrderItem> items,
    required _i36.Order order,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          TrackOrderRoute.name,
          args: TrackOrderRouteArgs(
            key: key,
            vId: vId,
            vNo: vNo,
            items: items,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'TrackOrderRoute';

  static const _i27.PageInfo<TrackOrderRouteArgs> page =
      _i27.PageInfo<TrackOrderRouteArgs>(name);
}

class TrackOrderRouteArgs {
  const TrackOrderRouteArgs({
    this.key,
    required this.vId,
    required this.vNo,
    required this.items,
    required this.order,
  });

  final _i28.Key? key;

  final int vId;

  final String vNo;

  final List<_i35.OrderItem> items;

  final _i36.Order order;

  @override
  String toString() {
    return 'TrackOrderRouteArgs{key: $key, vId: $vId, vNo: $vNo, items: $items, order: $order}';
  }
}

/// generated route for
/// [_i24.UnderMaintenanceScreen]
class UnderMaintenanceRoute extends _i27.PageRouteInfo<void> {
  const UnderMaintenanceRoute({List<_i27.PageRouteInfo>? children})
      : super(
          UnderMaintenanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnderMaintenanceRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i25.WebViewScreen]
class WebViewRoute extends _i27.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i28.Key? key,
    required _i37.WebViewController controller,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          WebViewRoute.name,
          args: WebViewRouteArgs(
            key: key,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'WebViewRoute';

  static const _i27.PageInfo<WebViewRouteArgs> page =
      _i27.PageInfo<WebViewRouteArgs>(name);
}

class WebViewRouteArgs {
  const WebViewRouteArgs({
    this.key,
    required this.controller,
  });

  final _i28.Key? key;

  final _i37.WebViewController controller;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i26.WishListScreen]
class WishListRoute extends _i27.PageRouteInfo<void> {
  const WishListRoute({List<_i27.PageRouteInfo>? children})
      : super(
          WishListRoute.name,
          initialChildren: children,
        );

  static const String name = 'WishListRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}
