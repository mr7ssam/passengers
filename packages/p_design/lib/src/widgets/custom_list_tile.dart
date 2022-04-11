import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
    this.borderRadius = 0,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final GestureTapCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Theme
          .of(context)
          .cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            children: [
              icon,
              const RSizedBox.horizontal(12),
              YouText.bodyMedium(text),
              if (onTap != null) ...[
                const Spacer(),
                const Icon(PIcons.outline_arrow___right__1),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

