import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/home/models/category.dart';
import 'package:base_ecom_appsure/features/home/presentation/categories/categories.dart';
import 'package:base_ecom_appsure/features/home/providers/home_provider.dart';
import 'package:base_ecom_appsure/widgets/responsive_builder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sanafer/gen/assets.gen.dart';
import 'package:sanafer/routes/app_router.gr.dart';
import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

import '../../theme/colors.dart';

@RoutePage()
class CategoriesTab extends ConsumerStatefulWidget {
  const CategoriesTab({
    super.key,
  });

  @override
  ConsumerState<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends ConsumerState<CategoriesTab> {

  List<Category> categories = [];
  int? categoryId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  Future<void> _refresh() async {
    await ref.read(homeProvider).getCategoryListForComponent();
  }

  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final state = ref.watch(categoriesProvider);
    categoryId ??= state.data![0].id;
    categories = settings.selectedLocale!.subCategoriesOf(categoryId!);
    ref.listen(settingsProvider, (previous, next) => _refresh());
  //   return Scaffold(
  //     appBar: AlSanaferAppBar(
  //       leading: Align(
  //           alignment: Alignment.centerLeft,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(settings.selectedLocale!.translate('Categories'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
  //           )),
  //     ),
  //     body: state.when(
  //         onLoading: () => SizedBox(
  //           height: double.infinity,
  //           width: double.infinity,
  //           child: Padding(
  //             padding: const EdgeInsets.all(5.0),
  //             child: Row(
  //               children: [
  //                 Flexible(
  //                   flex: 3,
  //                   child: ListView.builder(
  //                     itemCount: 10,
  //                     itemBuilder: (context,index){
  //                       return CategoryItemLeftSideNavShimmer();
  //                     }
  //                   )
  //                 ),
  //                 Flexible(
  //                     flex: 10,
  //                     child: GridView.count(
  //                       shrinkWrap: true,
  //                       physics: const AlwaysScrollableScrollPhysics(),
  //                       padding:
  //                       const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
  //                         bottom: 16.0,
  //                       ),
  //                       childAspectRatio: 0.8,
  //                       crossAxisCount: 3,
  //                       crossAxisSpacing: 8,
  //                       mainAxisSpacing: 8,
  //                       children: List.generate(
  //                         30,
  //                             (index) => const CategoryItemShimmer(),
  //                       ),
  //                     ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //         onSuccess: (data) => Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Card(
  //               elevation: 10,
  //               child: SideMenu(
  //                 showToggle: true,
  //                 collapseWidth: 10,
  //                 style: SideMenuStyle(
  //                   displayMode: SideMenuDisplayMode.auto,
  //                   decoration: BoxDecoration(),
  //                   openSideMenuWidth: MediaQuery.of(context).size.height * 0.1,
  //                   compactSideMenuWidth: 40,
  //                   hoverColor: smartSuiteBlue,
  //                   selectedColor: smartSuiteBlue,
  //                   selectedIconColor: Colors.white,
  //                   unselectedIconColor: Colors.black54,
  //                   backgroundColor: Colors.grey.shade100,
  //                   selectedTitleTextStyle: TextStyle(color: Colors.white),
  //                   unselectedTitleTextStyle: TextStyle(color: Colors.black54),
  //                   iconSize: 20,
  //                   itemBorderRadius: const BorderRadius.all(
  //                     Radius.circular(5.0),
  //                   ),
  //                   showTooltip: true,
  //                   itemHeight: MediaQuery.of(context).size.height * 0.08,
  //                   itemInnerSpacing: 15.0,
  //                   itemOuterPadding: const EdgeInsets.symmetric(vertical: 10.0),
  //                   toggleColor: Colors.black54,
  //
  //                   // Additional properties for expandable items
  //                   selectedTitleTextStyleExpandable: TextStyle(color: Colors.white), // Adjust the style as needed
  //                   unselectedTitleTextStyleExpandable: TextStyle(color: Colors.black54), // Adjust the style as needed
  //                   selectedIconColorExpandable: Colors.white, // Adjust the color as needed
  //                   unselectedIconColorExpandable: Colors.black54, // Adjust the color as needed
  //                   arrowCollapse: Colors.blueGrey, // Adjust the color as needed
  //                   arrowOpen: Colors.lightBlueAccent, // Adjust the color as needed
  //                   iconSizeExpandable: 24.0, // Adjust the size as needed
  //                 ),
  //                 controller: sideMenu,
  //                 onDisplayModeChanged: (mode) {
  //                   print(mode);
  //                 },
  //                 items: data.map((category) {
  //                   return SideMenuItem(
  //                     // badgeContent: Image.network(category.imagePath.toString()),
  //                     // iconWidget: Image.network(category.imagePath.toString()),
  //                     // title: category.title,
  //                     builder: (context,_){
  //                       return GestureDetector(
  //                         onTap: (){
  //                           sideMenu.changePage(category.id);
  //                           setState(() {
  //                             categoryId = category.id;
  //                             categories = settings.selectedLocale!.subCategoriesOf(categoryId!);
  //                           });
  //                         },
  //                         child: Container(
  //                             decoration: BoxDecoration(
  //                               color: category.id == sideMenu.currentPage ? smartSuiteBlue : Colors.white,
  //                               borderRadius: BorderRadius.circular(10.0),
  //                             ),
  //                             padding: const EdgeInsets.all(8.0),
  //                             margin: const EdgeInsets.only(bottom: 8.0,right: 3),
  //                             child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children:[
  //                                   ClipRRect(
  //                                     borderRadius: BorderRadius.circular(10.0), // This clips the child of this widget to the same border radius.
  //                                     child: Image.network(
  //                                       category.imagePath.toString(),
  //                                       fit: BoxFit.fill,
  //                                     ),
  //                                   ),
  //                                   const SizedBox(height: 3),
  //                                   Center(child: Text(category.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: category.id == sideMenu.currentPage ? Colors.white : Colors.black, fontSize: 9,fontWeight: FontWeight.w600),)),
  //                                 ]
  //                             )),
  //                       );
  //                     },
  //                     onTap: (index, _) {
  //                       sideMenu.changePage(index);
  //                       setState(() {
  //                         categoryId = category.id;
  //                         categories = settings.selectedLocale!.subCategoriesOf(categoryId!);
  //                       });
  //                     },
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //             Expanded(
  //               child: PageView(
  //                 controller: pageController,
  //                 children: [
  //                   GridView.count(
  //                     padding: const EdgeInsets.all(8),
  //                     childAspectRatio: 0.8,
  //                     crossAxisCount: Responsive.valueWhen(
  //                       context: context,
  //                       mobile: 3,
  //                       smallTablet: 4,
  //                       mediumTablet: 4,
  //                       largeTablet: 6,
  //                       desktop : 6,
  //                     ),
  //                     crossAxisSpacing: spacing(context),
  //                     mainAxisSpacing: spacing(context),
  //                     shrinkWrap: true,
  //                     children: categories
  //                         .map(
  //                           (f) => CategoryItemBase.widget(
  //                         category: f,
  //                         onTap: (haveChildren) {
  //                           if (haveChildren) {
  //                             context.pushRoute(SubcategoriesRoute(
  //                               category: f,
  //                               // parents: [...parents, ...categories],
  //                               parents: categories,
  //                             ));
  //                           } else {
  //                             context.pushRoute(
  //                               ProductsListingRoute(
  //                                 category: f,
  //                                 parentCategories: categories,
  //                               ),
  //                             );
  //                           }
  //                         },
  //                         errorImage: DecorationImage(
  //                           image: Assets.images.sanaferlogo.provider(),
  //                         ),
  //                       ),
  //                     )
  //                         .toList(),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       onError: (error) => const SizedBox.shrink(),
  //     ),
  //   );
  // }
  //
  // double spacing(BuildContext context) => Responsive.valueWhen(
  //   context: context,
  //   mobile: 4,
  //   smallTablet: 16,
  //   mediumTablet: 16,
  //   largeTablet: 32,
  //   desktop: 32,
  // );

    return Scaffold(
      appBar: AlSanaferAppBar(
        backgroundColor: true,
        leading: Align(
          // alignment: Alignment.centerLeft,
          child: Text(
            settings.selectedLocale!.translate('Categories'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Text(
                //     settings.selectedLocale!.translate('Categories'),
                //     style: Theme.of(context).textTheme.headlineMedium,
                //   ),
                // ),
                state.when(
                  onLoading: () => GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                      bottom: 16.0,
                    ),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                      6,
                          (index) => const CategoryItemShimmer(),
                    ),
                  ),
                  onSuccess: (data) => GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                      bottom: 16.0,
                    ),
                    crossAxisCount: Responsive.valueWhen(
                      context: context,
                      mobile: 3,
                      smallTablet: 4,
                      mediumTablet: 4,
                      largeTablet: 6,
                      desktop: 6,
                    ),
                    crossAxisSpacing: spacing(context),
                    mainAxisSpacing: spacing(context),
                    children: data
                        .map((e) => CategoryItemBase.widget(
                      category: e,
                      onTap: (haveChildren) {
                        if (haveChildren) {
                          context.pushRoute(
                            SubcategoriesRoute(
                              category: e,
                              backTitle: "Categories",
                            ),
                          );
                        } else {
                          context.pushRoute(ProductsListingRoute(
                            category: e,
                          ));
                        }
                      },
                    ))
                        .toList(),
                  ),
                  onError: (error) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double spacing(BuildContext context) => Responsive.valueWhen(
    context: context,
    mobile: 8,
    smallTablet: 16,
    mediumTablet: 16,
    largeTablet: 16,
    desktop: 16,
  );

  Future<dynamic> showBS(
      BuildContext context,
      AppSettingsprovider settings,
      int id,
      String title,
      ) =>
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
                child: Text(
                  settings.selectedLocale!.translate(title),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: settings.selectedLocale!
                    .subCategoriesOf(id)
                    .map(
                      (category) => TextButton(
                    onPressed: () => context.pushRoute(
                      ProductsListingRoute(
                        category: category,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      );
}
