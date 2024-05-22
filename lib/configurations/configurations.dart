import 'package:base_ecom_appsure/app_config/config.dart';
import 'package:flutter/foundation.dart';

Config get appConfig {
  switch (const String.fromEnvironment('CONFIG')) {
    case 'demo':
      return const AlayshDemo();
    case 'live':
      return const AlayshLive();
    default:
      return const AlayshDemo();
  }
}

@immutable
class AlayshDemo implements Config {
  const AlayshDemo();
  // @override
  // String get baseUrl => "https://demo.smartsolns.net/alaysh/ecommerceapi/api";
  @override
  String get baseUrl => "https://demo.smartsolns.net/sanaferv5/ecommerceapi/api";
  // String get baseUrl => "https://demo.smartsolns.org/sanaferv5/ecommerceapi/api";

  // @override
  // String get whatsappMessageUrl => "https://demo.smartsolns.net/alaysh/ecommerce";
  @override
  String get whatsappMessageUrl => "https://demo.smartsolns.net/sanaferv5/ecommerceapi";
}

@immutable
class AlayshLive implements Config {
  const AlayshLive();
  @override
  String get baseUrl => "https://alaysh.com/ecommerceapi/api";

  @override
  String get whatsappMessageUrl => "https://alaysh.com";
}