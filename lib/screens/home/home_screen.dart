import 'dart:math';

// import 'package:base_ecom_appsure/features/addresses/presentation/choose_area_bs.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/app_config_provider.dart';
import 'package:base_ecom_appsure/features/auth/providers/auth_provider.dart';
import 'package:base_ecom_appsure/features/auth/providers/login_state_provider.dart';
import 'package:base_ecom_appsure/features/home/presentation/bottom_nav.dart';
import 'package:base_ecom_appsure/foundation/hive_repo.dart';
import 'package:sanafer/providers/home_context_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/screens/login_bs.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends ConsumerState<HomeScreen> {
  late TabsRouter tabsRouter;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = HiveRepo.instance.user;

      LoginState state;

      if (user != null) {
        ref.read(authProvider).refreshLocalUser();
        state = LoggedIn(user: user);
      } else {
        state = const LoggedOut();
      }

      if (ref.read(appConfigProvider).siteUnderMaintenance) {
        context.router.replaceAll([const UnderMaintenanceRoute()]);
      }

      ref.read(loginStateProvider.notifier).state = state;

      if (!ref.read(appConfigProvider).disableAreaPopup) {
        showAreaBS(context);
      }

      ref.read(homeContextProvider.notifier).state = ContextWrapper(
        context: context,
        number: Random().nextInt(100),
      );
    });
    super.initState();
  }

  void showAreaBS(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(12),
    //       topRight: Radius.circular(12),
    //     ),
    //   ),
    //   isScrollControlled: true,
    //   builder: (context) => const ChooseAreaBS(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginStateProvider, (previous, next) {
      if (next is LoginRequired) {
        showLoginBS(context);
        // context.pushRoute(const LoginRoute());
      } else if (next is LoggedOut) {
        FirebaseAnalytics.instance.setUserId(id: null);
        FirebaseAnalytics.instance.setUserProperty(
          name: 'name',
          value: null,
        );
      } else if (next is LoggedIn) {
        FirebaseAnalytics.instance.logLogin();
        FirebaseAnalytics.instance.setUserId(id: next.user.id.toString());
        FirebaseAnalytics.instance.setUserProperty(
          name: 'name',
          value: next.user.displayName,
        );
      }
    });
    return AutoTabsRouter.pageView(
      physics: const NeverScrollableScrollPhysics(),
      routes: const [
        HomeTab(),
        CategoriesTab(),
        // AlertsTab(),
        AccountTab(),
      ],
      builder: (context, child, _) {
        tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: HomeNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            showAlerts: false,
            onTap: (index) {
              final activeIndex = tabsRouter.activeIndex;
              late String emptyRoute;
              late String popUntil;
              switch (index) {
                case 0:
                  emptyRoute = HomeEmptyRoute.name;
                  popUntil = HomeTab.name;
                  break;

                case 1:
                  emptyRoute = CategoriesEmptyRoute.name;
                  popUntil = CategoriesTab.name;
                  break;

              // case 2:
              //   emptyRoute = CartEmptyRoute.name;
              //   popUntil = CartTab.name;
              //   break;

                case 2:
                  emptyRoute = AccountsEmptyRoute.name;
                  popUntil = AccountTab.name;
                  break;
              }

              if (index == activeIndex) {
                context
                    .innerRouterOf<StackRouter>(emptyRoute)!
                    .popUntil((route) => route.data?.name == popUntil);
              } else {
                tabsRouter.setActiveIndex(index);
              }
            },
          ),
        );
      },
    );
  }
}
