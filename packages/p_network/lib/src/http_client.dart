import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:p_core/p_core.dart';

/// A callback that returns a Dio response, presumably from a Dio method
/// it has called which performs an HTTP request, such as `dio.get()`,
/// `dio.post()`, etc.
typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

/// Function which takes a Dio response object and optionally maps it to an
/// instance of [AppHttpClientException].
typedef ResponseExceptionMapper = AppException? Function(
  Response response,
  Exception e,
);

class DioClient with DioMixin implements Dio {
  DioClient(
    this.baseUrl, {
    this.exceptionMapper,
    BaseOptions? baseOptions,
    List<Interceptor> interceptors = const [],
  }) {
    httpClientAdapter = DefaultHttpClientAdapter();
    options = baseOptions ?? BaseOptions();
    options
      ..baseUrl = baseUrl
      ..headers = {'Content-Type': 'application/json; charset=UTF-8'};
    if (interceptors.isNotEmpty) {
      this.interceptors.addAll(interceptors);
    }
  }

  final ResponseExceptionMapper? exceptionMapper;

  final String baseUrl;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ResponseExceptionMapper? exceptionMapper,
  }) {
    return _mapException(
      () => super.get(
        path,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    ResponseExceptionMapper? exceptionMapper,
  }) {
    return _mapException(
      () => super.post(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    ResponseExceptionMapper? exceptionMapper,
  }) {
    return _mapException(
      () => super.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ResponseExceptionMapper? exceptionMapper,
  }) {
    return _mapException(
      () => super.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> _mapException<T>(
    HttpLibraryMethod<T> method, {
    ResponseExceptionMapper? mapper,
  }) async {
    try {
      return await method();
    } on DioError catch (exception) {
      if (exception.response?.statusCode.toString().matchAsPrefix('5') !=
          null) {
        throw AppNetworkException(
          reason: AppNetworkExceptionReason.serverError,
          exception: exception,
        );
      }
      switch (exception.type) {
        case DioErrorType.cancel:
          throw AppNetworkException(
            reason: AppNetworkExceptionReason.canceled,
            exception: exception,
          );
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          throw AppNetworkException(
            reason: AppNetworkExceptionReason.timedOut,
            exception: exception,
          );
        case DioErrorType.response:
          // For DioErrorType.response, we are guaranteed to have a
          // response object present on the exception.
          final response = exception.response;
          if (response == null || response is! Response<T>) {
            // This should never happen, judging by the current source code
            // for Dio.
            throw AppNetworkResponseException(exception: exception);
          }

          throw mapper?.call(response, exception) ??
              exceptionMapper?.call(response, exception) ??
              AppNetworkResponseException(
                exception: exception,
                statusCode: response.statusCode,
                data: response.data,
              );
        case DioErrorType.other:
        default:
          if (exception.error is SocketException) {
            throw AppNetworkException(
                reason: AppNetworkExceptionReason.noInternet,
                exception: exception);
          }
          throw AppException.unknown(exception: exception);
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw AppException.unknown(
        exception: e is Exception ? e : Exception('Unknown exception occurred'),
      );
    }
  }
}
