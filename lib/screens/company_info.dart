import 'package:base_ecom_appsure/features/company_info/models/company_info.dart';
import 'package:base_ecom_appsure/features/company_info/presentation/company_info_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:sanafer/widgets/al_sanafer_app_bar.dart';

@RoutePage()
class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({
    super.key,
    required this.type,
  });

  final InfoType type;

  @override
  Widget build(BuildContext context) {
    return CompanyInfoView(
      type: type,
      appBarBuilder: (title, showActions) => AlSanaferAppBar(
        title: title,
        showActions: showActions,
      ),
    );
  }
}
