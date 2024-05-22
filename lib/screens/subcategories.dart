import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/home/models/category.dart';
import 'package:base_ecom_appsure/features/home/presentation/categories/categories.dart';
import 'package:base_ecom_appsure/widgets/responsive_builder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class SubcategoriesScreen extends ConsumerWidget {
  const SubcategoriesScreen({
    super.key,
    required this.category,
    this.parents = const [],
    this.backTitle,
  });

  final Category category;
  final List<Category> parents;
  final String? backTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final settings = ref.watch(settingsProvider);
    final categories = settings.selectedLocale!.subCategoriesOf(category.id);
    return Scaffold(
      appBar: AlSanaferAppBar(
        backgroundColor: true,
        title: category.title,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8),
        childAspectRatio: 0.8,
        crossAxisCount: Responsive.valueWhen(
          context: context,
          mobile: 4,
          smallTablet: 4,
          mediumTablet: 4,
          largeTablet: 6,
          desktop : 6,
        ),
        crossAxisSpacing: spacing(context),
        mainAxisSpacing: spacing(context),
        shrinkWrap: true,
        children: categories
            .map(
              (f) => CategoryItemBase.widget(
            category: f,
            onTap: (haveChildren) {
              if (haveChildren) {
                context.pushRoute(SubcategoriesRoute(
                  category: f,
                  // parents: [...parents, ...categories],
                  parents: categories,
                ));
              } else {
                context.pushRoute(
                  ProductsListingRoute(
                    category: f,
                    parentCategories: categories,
                  ),
                );
              }
            },
            errorImage: DecorationImage(
              image: Assets.images.sanaferlogo.provider(),
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  double spacing(BuildContext context) => Responsive.valueWhen(
    context: context,
    mobile: 4,
    smallTablet: 16,
    mediumTablet: 16,
    largeTablet: 32,
    desktop: 32,
  );
}
