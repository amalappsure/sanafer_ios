import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:base_ecom_appsure/foundation/hive_repo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:base_ecom_appsure/app_config/config.dart';
import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:sanafer/routes/app_router.dart';
import 'package:sanafer/screens/splash.dart';
import 'package:sanafer/theme/colors.dart';
import 'package:sanafer/theme/text_theme_mulish.dart';
import 'configurations/configurations.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveRepo.initialize('alsanafer');
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  FirebaseAnalytics.instance.logAppOpen();

  CachedNetworkImage.logLevel = CacheManagerLogLevel.none;

  final getIt = GetIt.instance;
  getIt.registerSingleton<Config>(appConfig);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});


  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => ref.read(settingsProvider).getEcomAllSettings(),
    );
    super.initState();
  }

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(settingsProvider);

    if (provider.selectedLocale == null) {
      return const SplashScreen();
    }
    return Builder(
      builder: (context) {
        ScreenUtil.init(
          context,
          designSize: const Size(390, 844),
          minTextAdapt: true,
        );
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: provider.locales.map((e) => e.locale).toList(),
          locale: provider.selectedLocale!.locale,
          title: 'AlSanafer',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: smartSuiteBlue,
              primary: smartSuiteBlue,
              secondary: secondary,
              tertiary: tertiary,
              onPrimary: black,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: smartSuiteBlue,
              foregroundColor: white,
              actionsIconTheme: IconThemeData(
                color: white,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: white,
                backgroundColor: smartSuiteBlue,
                textStyle: mulishTheme.bodyLarge!.copyWith(
                  color: white,
                ),
              ),
            ),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: smartSuiteBlue,
              contentTextStyle: mulishTheme.labelLarge!.copyWith(
                color: white,
              ),
            ),
            checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.all(white),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: smartSuiteBlue,
                textStyle: mulishTheme.labelLarge!.copyWith(
                  color: smartSuiteBlue,
                ),
              ),
            ),
            useMaterial3: true,
            textTheme: mulishTheme,
          ),
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
