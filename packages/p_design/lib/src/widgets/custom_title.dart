import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    Key? key,
    this.icon,
    required this.label,
    this.mainAxisAlignment = MainAxisAlignment.start,
  })  : small = false,
        super(key: key);

  const CustomTitle.small({
    Key? key,
    this.icon,
    required this.label,
    this.mainAxisAlignment = MainAxisAlignment.start,
  })  : small = true,
        super(key: key);
  final Widget? icon;
  final Widget label;
  final bool small;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextStyle titleStyle =
        small ? theme.textTheme.bodySmall! : theme.textTheme.titleMedium!;
    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: label,
    );
    final iconTheme = theme.iconTheme;
    final effectiveIconTheme =
        small ? iconTheme.copyWith(size: 16.r) : iconTheme;
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (icon != null) ...[
          IconTheme(data: effectiveIconTheme, child: icon!),
          small ? Space.hS2 : Space.hM1,
        ],
        titleText,
      ],
    );
  }
}
