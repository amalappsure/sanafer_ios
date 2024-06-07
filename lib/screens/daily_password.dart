import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/cart/presentation/add_to_cart_button.dart';
import 'package:base_ecom_appsure/widgets/responsive_builder.dart';
import 'package:base_ecom_appsure/widgets/text_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';

import '../theme/colors.dart';


@RoutePage()
class DailyPasswordScreen extends ConsumerStatefulWidget {
  const DailyPasswordScreen({super.key});

  @override
  ConsumerState<DailyPasswordScreen> createState() => _DailyPasswordState();
}

class _DailyPasswordState extends ConsumerState<DailyPasswordScreen> {

  TextEditingController _password = TextEditingController();
  String number  = 'Smart@1234';
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Responsive(
            mobile: (context, constraints, child) => Assets.images.smartsolns.image(
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            desktop: (context, constraints, child) => Assets.images.smartsolns.image(
              height: MediaQuery.of(context).size.height * 0.45,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextFieldWithTitleBase.widget(
              controller: _password,
              hint: "Enter Password",
              onChanged: (value) {

              },
              maxLength: 10,
              counter: const SizedBox.shrink(),
              // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: _buyNowButton(
                    (){
                  if(_password.text == number){
                    context.replaceRoute(
                      const HomeRoute(),
                    );
                  }
                }
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  AddToCartButton _buyNowButton(VoidCallback? onPressed) {
    return AddToCartButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(20),
      icon: FontAwesomeIcons.arrowRightFromBracket,
      backgroundColor: smartSuiteBlue,
      label: 'OK',
      iconSize: 20,
      gap: 8,
    );
  }
}
