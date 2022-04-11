import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RPadding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator()),
    );
  }
}
