import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    Key? key,
    this.color,
    this.alignment = Alignment.center,
  }) : super(key: key);
  final Color? color;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: RPadding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(
            color: color,
          )),
    );
  }
}
