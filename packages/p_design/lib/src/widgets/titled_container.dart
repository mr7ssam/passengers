import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class TitledContainer extends StatelessWidget {
  const TitledContainer({
    Key? key,
    this.title,
    this.children = const [],
    this.borderRadius = PRadius.button,
  }) : super(key: key);
  final String? title;
  final List<Widget> children;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).cardColor;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  YouText.bodySmall(title!),
                ],
              ),
            ),
          ...children,
        ],
      ),
    );
  }
}
