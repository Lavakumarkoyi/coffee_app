import 'package:dio/dio.dart';

// import 'interceptors.dart';

class DioClient {
  late final Dio _dio;
  DioClient()
      : _dio = Dio(
          BaseOptions(
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              responseType: ResponseType.json,
              sendTimeout: const Duration(seconds: 100),
              receiveTimeout: const Duration(seconds: 100)),
        ) {
    // _dio.interceptors.addAll([LoggerInterceptor()]);
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> post(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.post(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> put(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.put(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.patch(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      return response;
    } on DioException {
      rethrow;
    }
  }
}
