import 'package:freezed_annotation/freezed_annotation.dart';

import '../../exceptions/exceptions.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure({
    required String message,
    required AppException exception,
  }) = Failure<T>;
}

extension ApiResultX<Object> on ApiResult<Object> {
  bool get isSuccess => this is Success;

  bool get isFailure => this is Failure;

  Failure get failure => this as Failure;

  Object get data => (this as Success).data;

  String get message => (this as Failure).message;

  AppException get exception => (this as Failure).exception;
}

extension ApiResultEx on Iterable<ApiResult> {
  ApiResult<T>? mayBeOnFailure<T>() {
    for (final r in this) {
      late String message;
      var maybeFailure = r.maybeWhen(
          orElse: () => false,
          failure: (m, _) {
            message = m;
            return true;
          });
      if (maybeFailure) {
        return ApiResult.failure(
          message: message,
          exception: r.exception,
        );
      }
    }
    return null;
  }
}
