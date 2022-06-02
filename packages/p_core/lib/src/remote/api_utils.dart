import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import '../exceptions/exceptions.dart';
import 'result/api_result.dart';

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
    if (e.data is! String) {
      return ApiResult.failure(
        message: e.data.toString(),
        exception: e,
      );
    }
    return ApiResult.failure(
      message: e.data,
      exception: e,
    );
  } on AppNetworkException catch (e) {
    final message = (prefix + e.message).tr();
    final appNetworkException = e.copyWith(message: message);
    return ApiResult.failure(
      message: message,
      exception: appNetworkException,
    );
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    final exception = AppException.unknown(exception: e);
    return ApiResult.failure(
      exception: exception,
      message: (prefix + exception.message).tr(),
    );
  }
}
