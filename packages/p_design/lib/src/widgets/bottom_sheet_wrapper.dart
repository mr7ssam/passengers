import 'package:flutter/material.dart';
import 'package:p_design/src/theme/const.dart';
import 'package:p_design/src/widgets/text.dart';

class BottomSheetWrapperWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets childrenPadding;

  const BottomSheetWrapperWidget({
    Key? key,
    required this.title,
    this.children = const [],
    this.childrenPadding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: PEdgeInsets.listView,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            YouText.titleLarge(title),
            if (children.isNotEmpty)
              Padding(
                padding: childrenPadding,
                child: Column(
                  children: children,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
