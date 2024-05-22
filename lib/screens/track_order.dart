import 'package:base_ecom_appsure/features/orders/models/orders_list/order.dart';
import 'package:base_ecom_appsure/features/orders/models/orders_list/order_item.dart';
import 'package:base_ecom_appsure/features/orders/presentation/track_order_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({
    super.key,
    required this.vId,
    required this.vNo,
    required this.items,
    required this.order,
  });

  final int vId;
  final String vNo;
  final Order order;
  final List<OrderItem> items;

  @override
  Widget build(BuildContext context) {
    return TrackOrderView(
      appBarBuilder: (title, showActions) => AlSanaferAppBar(
        title: title,
        showActions: showActions,
      ),
      order: order,
      items: items,
      vId: vId,
      vNo: vNo,
      onItemTapped: (value) => context.pushRoute(ProductDetailsRoute(
        productId: value.itemId,
        unitId: value.unitId,
      )),
    );
  }
}
