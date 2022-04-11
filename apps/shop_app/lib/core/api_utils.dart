import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:p_network/p_http_client.dart';

Future<T> throwAppException<T>(FutureOr<T> Function() call) async {
  try {
    return call();
  } on AppException catch (_) {
    rethrow;
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    throw AppException.unknown(exception: e);
  }
}

Future<ApiResult<T>> toApiResult<T>(FutureOr<T> Function() call,
    {String prefix = 'exceptions.'}) async {
  try {
    return ApiResult.success(data: await call());
  } on AppNetworkResponseException catch (e) {
    return ApiResult.failure(message: e.data);
  } on AppNetworkException catch (e) {
    return ApiResult.failure(message: (prefix + e.message).tr());
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    return ApiResult.failure(
      message: (prefix + AppException.unknown(exception: e).message).tr(),
    );
  }
}
