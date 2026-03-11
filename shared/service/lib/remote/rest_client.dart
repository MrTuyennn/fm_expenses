import 'package:dio/dio.dart';

abstract interface class IRestClient {
  /// GET
  Future<Response<dynamic>?> get(String path);

  /// POST
  Future<Response<dynamic>?> post(String path, String? dataPrams);

  /// DELETE
  Future<Response<dynamic>?> delete(String path, String? dataPrams);

  /// PUT
  Future<Response> put(String path, String? dataPrams);
}
