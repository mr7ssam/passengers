import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../generated/locale_keys.g.dart';

void dismissAllAndShowError(BuildContext context, String message) {
  EasyLoading.dismiss();
  final scaffoldMessengerState = ScaffoldMessenger.of(context);
  scaffoldMessengerState.removeCurrentSnackBar();
  scaffoldMessengerState.showSnackBar(SnackBar(content: Text(message)));
}

void showLoadingOverLay({String? message}) {
  EasyLoading.show(
    status: message ?? LocaleKeys.general_in_progress.tr(),
    maskType: EasyLoadingMaskType.black,
    indicator: const CircularProgressIndicator(),
  );
}
