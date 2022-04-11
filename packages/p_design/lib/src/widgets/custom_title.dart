import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key, this.icon, required this.label})
      : super(key: key);
  final Widget? icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.titleMedium!;
    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: label,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (icon != null) ...[
          icon!,
          Space.hM1,
        ],
        titleText,
      ],
    );
  }
}
