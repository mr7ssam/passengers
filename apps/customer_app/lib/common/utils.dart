import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'const/const.dart';

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.Hms(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

void dismissAllAndShowError(BuildContext context, String message) {
  EasyLoading.dismiss();
  final scaffoldMessengerState = ScaffoldMessenger.of(context);
  scaffoldMessengerState.removeCurrentSnackBar();
  scaffoldMessengerState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).errorColor,
      content: Text(
        message,
      )));
}

String? buildDocUrl(String? url) {
  if (url == null || url.isEmpty) {
    return null;
  }
  return '$kBaseUrl/$url';
}
