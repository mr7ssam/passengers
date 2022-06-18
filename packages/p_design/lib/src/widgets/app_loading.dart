import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RPadding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(
            color: color,
          )),
    );
  }
}
