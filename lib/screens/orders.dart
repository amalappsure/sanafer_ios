import 'package:base_ecom_appsure/features/orders/presentation/orders_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrdersView(
      appBarBuilder: (title, showActions) => AlSanaferAppBar(
        title: title,
        showActions: showActions,
      ),
      onProductClicked: (itemId, unitId) => context.pushRoute(
        ProductDetailsRoute(
          productId: itemId,
          unitId: unitId,
        ),
      ),
      onTrackClicked: (items, order) => context.pushRoute(
        TrackOrderRoute(
          vId: order.vid,
          vNo: order.vNo,
          items: items,
          order: order,
        ),
      ),
    );
  }
}
