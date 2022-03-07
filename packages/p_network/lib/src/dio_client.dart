import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioClient with DioMixin implements Dio {
  DioClient(
    this.baseUrl, {
    BaseOptions? baseOptions,
    List<Interceptor> interceptors = const [],
  }) {
    httpClientAdapter = DefaultHttpClientAdapter();
    options = baseOptions ?? BaseOptions();
    options
      ..baseUrl = baseUrl
      ..headers = {'Content-Type': 'application/json; charset=UTF-8'};

    final logInterceptor = LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    );
    this.interceptors.add(logInterceptor);

    if (interceptors.isNotEmpty) {
      this.interceptors.addAll(interceptors);
    }
  }

  final String baseUrl;
}
