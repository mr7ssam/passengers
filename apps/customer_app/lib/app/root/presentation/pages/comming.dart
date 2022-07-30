import 'package:customer_app/app/root/presentation/widgets/page_name_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p_design/p_design.dart';

class ComingPage extends StatelessWidget with PageNameMixin {
  const ComingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        EmptyState.comingSoon,
      ),
    );
  }

  @override
  String get pageName => 'coming';
}
