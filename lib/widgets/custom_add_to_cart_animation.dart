import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:base_ecom_appsure/foundation/add_to_cart_anim_controller.dart';
import 'package:flutter/material.dart';

class CustomAddToCartAnimation extends StatelessWidget {
  const CustomAddToCartAnimation({
    required this.child,
    required this.cartKey,
    required this.animationController,
    super.key,
  });

  final Widget child;
  final GlobalKey<CartIconKey> cartKey;
  final AddToCartAnimController animationController;

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
        duration: Duration(milliseconds: 300),
      ),
      jumpAnimation: const JumpAnimationOptions(active: false),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod,
        // just pass trough the the global key of  the image as parameter
        animationController.run = runAddToCartAnimation;
      },
      cartKey: cartKey,
      child: child,
    );
  }
}
