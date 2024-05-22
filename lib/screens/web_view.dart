import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class WebViewScreen extends StatelessWidget {
  const WebViewScreen({
    super.key,
    required this.controller,
  });

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: controller,

      ),
    );
  }
}
