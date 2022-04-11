import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class TitledIcon extends StatelessWidget {
  const TitledIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const RSizedBox.horizontal(6),
        Text(text),
      ],
    );
  }
}
