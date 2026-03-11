import 'package:dio/dio.dart';

import './rest_interceptors_client.dart';
import './rest_client.dart';

class RestClient implements IRestClient {
  late Dio _dio;

  RestClient({String? baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? 'http//:',
      // connectTimeout: Endpoints.connectionTimeout,
      // receiveTimeout: Endpoints.receiveTimeout,
      responseType: ResponseType.json,
      contentType: Headers.formUrlEncodedContentType,
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
  Future<Response<dynamic>?> post(String path, String? dataPrams) async {
    try {
      return await _dio.post(path, data: {'JSON': "$dataPrams"});
    } catch (e) {
      if (e is DioException) {
        return e.response;
      }
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> put(String path, String? dataPrams) {
    return _dio.put(path);
  }
}
