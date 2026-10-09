import 'package:dio/dio.dart';

import '../model/exception.dart';

mixin ApiScopeMixin {
  /// Unwraps the backend's success envelope `{"data": ...}` and runs
  /// [deserialize] on whatever `data` holds — a `Map` for a single object,
  /// a `List` for a collection. Any 4xx/5xx response (body `{"error": "..."}`)
  /// surfaces as a [CoreException] via Dio's error path.
  Future<T> runApiScope<T>({
    required Future<Response<dynamic>?> Function() request,
    required T Function(dynamic) deserialize,
  }) async {
    try {
      final res = await request();
      final body = res?.data;
      if (body is Map<String, dynamic> && body.containsKey('data')) {
        return deserialize(body['data']);
      }
      throw CoreException.nullReferenceException(
        'Unexpected response shape',
        res?.statusCode,
      );
    } on CoreException {
      rethrow;
    } on Exception catch (e) {
      throw CoreException(e);
    }
  }

  /// Same as [runApiScope] but for endpoints with no response body to parse
  /// (e.g. `DELETE` returning `204 No Content`).
  Future<void> runApiScopeVoid({
    required Future<Response<dynamic>?> Function() request,
  }) async {
    try {
      await request();
    } on CoreException {
      rethrow;
    } on Exception catch (e) {
      throw CoreException(e);
    }
  }
}
