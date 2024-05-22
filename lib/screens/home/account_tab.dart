import 'dart:math';

import 'package:base_ecom_appsure/features/app_settings/providers/app_config_provider.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/auth/providers/login_state_provider.dart';
import 'package:base_ecom_appsure/features/cart/providers/cart_provider.dart';
import 'package:base_ecom_appsure/features/company_info/models/company_info.dart';
import 'package:base_ecom_appsure/features/home/presentation/account_tab_button.dart';
import 'package:base_ecom_appsure/features/home/presentation/social_button.dart';
import 'package:base_ecom_appsure/foundation/hive_repo.dart';
import 'package:base_ecom_appsure/foundation/string_exts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/theme/colors.dart' as colors;

import 'package:sanafer/theme/colors.dart';

@RoutePage()
class AccountTab extends ConsumerStatefulWidget {
  const AccountTab({super.key});

  @override
  ConsumerState<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends ConsumerState<AccountTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        if (!HiveRepo.instance.isLoggedIn) {
          ref.read(loginStateProvider.notifier).state = LoginRequired(
            Random().nextInt(100),
          );
        }
      },
    );
    super.initState();
  }

  String intToRGB(int i) {
    String c = (i & 0x00FFFFFF).toRadixString(16).toUpperCase();
    return "00000".substring(0, 6 - c.length) + c;
  }

  Color stringToColor(String string) => Color(
    int.parse("FF${intToRGB(string.hashCode)}", radix: 16),
  );

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);
    final settings = ref.watch(settingsProvider);
    final appConfig = ref.read(appConfigProvider);

    final common = [
      AccountTabButton(
          onPressed: () => settings.selectedLocale = settings.unselectedLocale,
          text: settings.selectedLocale!.translate(
            'Language',
          ),
          arrowWidget: Text(settings.unselectedLocale?.displayName ?? '',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colors.black,
                  )),
          textColor: Colors.black,
          icon: Iconsax.translate,
          iconColor: smartSuiteBlue,
        ),
      AccountTabButton(
        onPressed: () => context.pushRoute(
          CompanyInfoRoute(type: InfoType.about),
        ),
        text: settings.selectedLocale!.translate(
          'About Us',
        ),
        textColor: Colors.black,
        icon: Iconsax.people,
        iconColor: smartSuiteBlue,
      ),
      AccountTabButton(
        onPressed: () => context.pushRoute(
          CompanyInfoRoute(type: InfoType.contact),
        ),
        text: settings.selectedLocale!.translate(
          'ContactUs',
        ),
        textColor: Colors.black,
        icon: Iconsax.call,
        iconColor: smartSuiteBlue,
      ),
      AccountTabButton(
        onPressed: () => context.pushRoute(
          CompanyInfoRoute(type: InfoType.returnAndExchange),
        ),
        text: settings.selectedLocale!.translate(
          'TermsandConditions',
        ),
        textColor: Colors.black,
        icon: Iconsax.document,
        iconColor: smartSuiteBlue,
      ),
      AccountTabButton(
        onPressed: () => context.pushRoute(
          CompanyInfoRoute(type: InfoType.privacy),
        ),
        text: settings.selectedLocale!.translate(
          'PrivacyPolicy',
        ),
        textColor: Colors.black,
        icon: Iconsax.security_user,
        iconColor: smartSuiteBlue,
      ),
      if (appConfig.enableWhatsappEnquiryGen &&
          appConfig.whatsappEnquiryNumber.isNotEmpty)
        AccountTabButton(
          onPressed: () {
            final number = appConfig.whatsappEnquiryNumber;
            final url = 'https://wa.me/$number';
            final uri = Uri.parse(url);
            launchUrl(uri);
          },
          text: settings.selectedLocale!.translate(
            'TextUsWhatsapp',
          ),
          textColor: Colors.black,
          iconWidget: Assets.svgs.whatsappIcon.svg(color: smartSuiteBlue),
          iconColor: smartSuiteBlue,
        ),
      if (appConfig.contactEmail.isNotEmpty)
        AccountTabButton(
          onPressed: () {
            final email = appConfig.contactEmail;
            final url = 'mailto:$email';
            final uri = Uri.parse(url);
            launchUrl(uri);
          },
          text: settings.selectedLocale!.translate(
            'HomeContactUs',
          ),
          textColor: Colors.black,
          icon: Iconsax.sms_tracking,
          iconColor: smartSuiteBlue,
        ),
    ];

    // final languageButton = AccountTabButton(
    //   onPressed: () => settings.selectedLocale = settings.unselectedLocale,
    //   text: settings.selectedLocale!.translate(
    //     'Language',
    //   ),
    //   arrowWidget: Text(settings.unselectedLocale?.displayName ?? '',
    //       style: Theme.of(context).textTheme.titleSmall?.copyWith(
    //             color: colors.black,
    //           )),
    //   textColor: Colors.black,
    //   icon: Iconsax.translate,
    //   iconColor: smartSuiteBlue,
    // );

    final signedOutList = [
      // languageButton,
      AccountTabButton(
        onPressed: () {
          ref.read(loginStateProvider.notifier).state = LoginRequired(
            Random().nextInt(100),
          );
        },
        text: settings.selectedLocale!.translate(
          'LoginAndSignup',
        ),
        textColor: Colors.black,
        icon: Iconsax.login_1,
        iconColor: smartSuiteBlue,
      ),
      ...common,
    ];

    final signedInList = [
      // languageButton,
      AccountTabButton(
        onPressed: () => context.pushRoute(
          const OrdersRoute(),
        ),
        text: settings.selectedLocale!.translate(
          'YourOrders',
        ),
        textColor: const Color.fromARGB(255, 97, 32, 32),
        icon: Iconsax.box,
        iconColor: smartSuiteBlue,
      ),
      AccountTabButton(
        onPressed: () => context.pushRoute(
          const AddressesRoute(),
        ),
        text: settings.selectedLocale!.translate(
          'YourAddresses',
        ),
        textColor: Colors.black,
        icon: Iconsax.map,
        iconColor: smartSuiteBlue,
      ),
      if (ref.read(appConfigProvider).enablewishlist)
        AccountTabButton(
          onPressed: () => context.pushRoute(
            const WishListRoute(),
          ),
          text: settings.selectedLocale!.translate(
            'YourWishList',
          ),
          textColor: Colors.black,
          icon: Iconsax.heart,
          iconColor: smartSuiteBlue,
        ),
      // AccountTabButton(
      //   text: settings.selectedLocale!.translate(
      //     'Notifications',
      //   ),
      //   textColor: Colors.black,
      //   icon: Iconsax.notification,
      //   iconColor: colors.black,
      // ),
      AccountTabButton(
        onPressed: () => context.pushRoute(
          const EditProfileRoute(),
        ),
        text: settings.selectedLocale!.translate(
          'Login&Security',
        ),
        textColor: Colors.black,
        icon: Iconsax.user,
        iconColor: smartSuiteBlue,
      ),
      ...common,
      AccountTabButton(
        onPressed: () async {
          ref.read(cartProvider).clearLocalCart();
          await HiveRepo.instance.logout();
          ref.read(loginStateProvider.notifier).state = const LoggedOut();
        },
        text: settings.selectedLocale!.translate(
          'SignOut',
        ),
        textColor: Theme.of(context).colorScheme.error,
        icon: Iconsax.logout_1,
        iconColor: Theme.of(context).colorScheme.error,
        showArrow: false,
      ),
    ];

    final list = loginState is LoggedIn ? signedInList : signedOutList;

    const iconSize = 40.0;
    return Scaffold(
      appBar: AlSanaferAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0,right: 4.0),
          child: Assets.images.sanaferlogo.image(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (HiveRepo.instance.isLoggedIn)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(
                    top: 16.0,
                  ),
                  child: Row(
                    children: [
                      if (HiveRepo.instance.user != null)
                        Container(
                          padding: const EdgeInsets.all(18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: stringToColor(
                              HiveRepo.instance.user!.name!,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Builder(builder: (context) {
                            return Text(
                              HiveRepo
                                  .instance.user!.displayName.characters.first
                                  .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(color: Colors.white),
                            );
                          }),
                        ),
                      const Gap(10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (HiveRepo.instance.user?.displayName != null)
                              AutoSizeText(
                                HiveRepo.instance.user!.displayName,
                                style:
                                Theme.of(context).textTheme.headlineMedium,
                                maxLines: 1,
                              ),
                            Text(
                              HiveRepo.instance.user?.email ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => list[index],
            ),
            const Gap(6.0),
            if (appConfig.enableSocialMediaIconsAndFunctionality)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (appConfig.facebookURL.nullIfEmpty != null)
                    SocialButton(
                      url: appConfig.facebookURL!,
                      child: Assets.svgs.facebook.svg(width: iconSize),
                    ),
                  if (appConfig.instagramURL.nullIfEmpty != null)
                    SocialButton(
                      url: appConfig.instagramURL!,
                      child: Assets.svgs.instagram.svg(width: iconSize),
                    ),
                  if (appConfig.linkedInURL.nullIfEmpty != null)
                    SocialButton(
                      url: appConfig.linkedInURL!,
                      child: Assets.svgs.linkedin.svg(width: iconSize),
                    ),
                  if (appConfig.youTubeURL.nullIfEmpty != null)
                    SocialButton(
                      url: appConfig.youTubeURL!,
                      child: Assets.svgs.youtube.svg(width: iconSize),
                    ),
                  if (appConfig.twitterURL.nullIfEmpty != null)
                    SocialButton(
                      url: appConfig.twitterURL!,
                      child: Assets.svgs.twitterx.svg(width: iconSize),
                    ),
                ],
              ),
            const Gap(16),
            Center(
              child: FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final packageInfo = snapshot.data!;
                    return Text(
                      'v${packageInfo.version}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
