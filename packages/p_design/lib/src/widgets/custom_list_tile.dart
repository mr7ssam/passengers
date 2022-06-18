import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.icon,
    this.trilling,
    required this.text,
    this.onTap,
    this.borderRadius = PRadius.container,
    this.children = const [],
  }) : super(key: key);

  final Widget? icon;
  final Widget? trilling;
  final List<Widget> children;
  final String text;
  final GestureTapCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  if (icon != null) icon!,
                  const RSizedBox.horizontal(12),
                  YouText.bodyMedium(text),
                  if (trilling != null || onTap != null) const Spacer(),
                  if (onTap != null && trilling == null) ...[
                    const Icon(PIcons.outline_arrow___right__1),
                  ],
                  if (trilling != null) trilling!,
                ],
              ),
              if (children.isNotEmpty) ...children
            ],
          ),
        ),
      ),
    );
  }
}
