import 'package:base_ecom_appsure/features/addresses/models/address.dart';
import 'package:base_ecom_appsure/features/cart/models/cart_item.dart';
import 'package:base_ecom_appsure/features/orders/presentation/order_placed_view.dart';
import 'package:base_ecom_appsure/features/products/models/payment_methods.dart';
import 'package:auto_route/auto_route.dart' hide AppBarBuilder;
import 'package:flutter/material.dart';
import 'package:sanafer/theme/colors.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({
    super.key,
    required this.items,
    this.failed = false,
    this.deliveryAddress,
    this.paymentMethod,
    this.total,
  });

  final List<CartItem> items;
  final bool failed;
  final Address? deliveryAddress;
  final PaymentMethod? paymentMethod;
  final double? total;

  @override
  Widget build(BuildContext context) {
    return OrderPlacedView(
      items: items,
      failed: failed,
      appBarBuilder: (title, showActions) => AlSanaferAppBar(
        title: title,
        showActions: showActions,
      ),
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      total: total,
      color: smartSuiteBlue,
    );
  }
}
