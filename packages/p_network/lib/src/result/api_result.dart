import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure({required String message}) = Failure<T>;
}

extension ApiResultEx on Iterable<ApiResult> {
  ApiResult<T>? mayBeOnFailure<T>() {
    for (final r in this) {
      late String message;
      var maybeFailure = r.maybeWhen(
          orElse: () => false,
          failure: (_) {
            message = _;
            return true;
          });
      if (maybeFailure) {
        return ApiResult.failure(message: message);
      }
    }
    return null;
  }
}
