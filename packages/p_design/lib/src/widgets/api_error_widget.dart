import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';

class APIErrorWidget extends StatelessWidget {
  const APIErrorWidget({
    Key? key,
    required this.exception,
  }) : super(key: key);

  final AppException exception;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            exception.noInternetConnection
                ? EmptyState.noInternetConnection
                : EmptyState.somethingWentWrong,
          ),
          YouText.bodySmall(exception.message)
        ],
      ),
    );
  }
}
