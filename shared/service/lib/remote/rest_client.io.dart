import 'package:dio/dio.dart';

import './rest_client.dart';
import './rest_interceptors_client.dart';

class RestClient implements IRestClient {
  late Dio _dio;

  RestClient({String? baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? 'http//:',
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    );

    _dio = Dio(options);
    _dio.interceptors.add(RestInterceptorsClient());
  }

  @override
  Future<Response<dynamic>?> delete(String path, String? dataPrams) {
    return _dio.delete(path);
  }

  @override
  Future<Response<dynamic>?> get(String path) {
    return _dio.get(path);
  }

  @override
  Future<Response<dynamic>?> post(String path, String? dataPrams) {
    return _dio.post(path, data: dataPrams);
  }

  @override
  Future<Response<dynamic>> put(String path, String? dataPrams) {
    return _dio.put(path);
  }
}
