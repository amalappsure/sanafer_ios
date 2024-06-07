import 'package:base_ecom_appsure/features/app_settings/providers/settings_provider.dart';
import 'package:base_ecom_appsure/features/home/models/category.dart';
import 'package:base_ecom_appsure/features/products/models/search_result.dart';
import 'package:base_ecom_appsure/features/products/providers/product_search_provider/product_search_states.dart';
import 'package:base_ecom_appsure/features/products/providers/product_search_provider/provider.dart';
import 'package:base_ecom_appsure/widgets/text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sanafer/routes/app_router.gr.dart';

class SearchProductsDialog {
  static Future<void> show(BuildContext context) async {
    final result = await showGeneralDialog<dynamic>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const _SearchProductsDialog();
      },
    );

    if (result is String) {
      // ignore: use_build_context_synchronously
      context.pushRoute(
        ProductsListingRoute(searchQuery: result),
      );
    } else if (result is SearchResult) {
      if (result.type == 'Category') {
        // ignore: use_build_context_synchronously
        context.pushRoute(
          ProductsListingRoute(
            category: Category(
              id: result.id,
              title: result.description ?? '',
            ),
          ),
        );
      } else if (result.type == 'Product') {
        // ignore: use_build_context_synchronously
        context.pushRoute(
          ProductDetailsRoute(
            productId: result.id,
            unitId: result.unitId ?? 1,
          ),
        );
      }
    }
  }
}

class _SearchProductsDialog extends ConsumerStatefulWidget {
  const _SearchProductsDialog();

  @override
  ConsumerState<_SearchProductsDialog> createState() =>
      _SearchProductsDialogState();
}

class _SearchProductsDialogState extends ConsumerState<_SearchProductsDialog> {
  List<SearchResult>? list;
  final _editingController = TextEditingController();

  void initListeners() {
    ref.listen(
      productSearchProvider,
          (prev, next) {
        if (next is ProductSearchSuccess) {
          if (list == null) {
            list = [];
          } else {
            list!.clear();
          }

          list!.addAll(next.data);
        } else if (next is ProductSearchError) {
          if (list == null) {
            list = [];
          } else {
            list!.clear();
          }
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final listState = ref.watch(productSearchProvider);
    final settings = ref.watch(settingsProvider);

    initListeners();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Padding(
          padding: EdgeInsets.only(
            right: isRtl ? 0.0 : 8.0,
            left: isRtl ? 8.0 : 0.0,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            // padding: const EdgeInsets.only(right: 10.0),
            child: CustomTextFieldBase.widget(
              autofocus: true,
              controller: _editingController,
              fillColor: Colors.white,
              prefixIcon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.grey.shade500,
              ),
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                if (value.isEmpty) return;
                context.popRoute(value);
              },
              borderColor: Colors.grey.shade500,
              hint: settings.selectedLocale!.translate('Search'),
              onChanged: (value) =>
                  ref.read(productSearchProvider.notifier).getSearchList(
                    value,
                  ),
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (listState is ProductSearchError ||
              listState is ProductSearchInitial) {
            return const SizedBox.shrink();
          }
          if (list == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return ListView.separated(
              itemCount: list!.length + 1,
              itemBuilder: (context, index) {
                if (index >= list!.length) {
                  if (_editingController.text.isEmpty) {
                    return const SizedBox.shrink();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFF898D90),
                              width: 1,
                            ),
                          ),
                        child: Center(
                          child: _textButton(
                            onPressed: () {
                              context.popRoute(_editingController.text);
                            },
                            child: RichText(
                              text: TextSpan(
                                style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: settings.selectedLocale!.translate(
                                      'viewallsearchresultsfor',
                                    ),
                                  ),
                                  TextSpan(
                                    text:  " '${_editingController.text}'",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }

                return _textButton(
                  onPressed: () {
                    context.popRoute(list![index]);
                    ref.read(productSearchProvider.notifier).clearList();
                  },
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: list![index].imagePathUrl!.isNotEmpty ? Image.network(list![index].imagePathUrl ?? '') : Icon(Icons.search_sharp),
                          )),
                      const SizedBox(width: 10,),
                      Flexible(
                        flex: 9,
                        child: Text(
                          list![index].description ?? '',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
            );
          }
        },
      ),
    );
  }

  TextButton _textButton({
    required Widget child,
    VoidCallback? onPressed,
  }) =>
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(5.0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
        ),
        child: child,
      );
}
