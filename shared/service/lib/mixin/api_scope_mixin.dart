import 'package:dio/dio.dart';

import '../model/exception.dart';
import '../model/response.dart';

mixin ApiScopeMixin {
  Future<T> runApiScope<T>({
    required Future<Response<dynamic>?> Function() request,
    required T Function(Map<String, dynamic>) deserialize,
    String? errorMessage,
  }) async {
    try {
      final res = await request();

      final response = BaseResponse<T>.fromJson(
        json: res?.data,
        deserialize: deserialize,
      );

      if (response.data == null) {
        throw CoreException.nullReferenceException(
          response.message,
          response.code,
        );
      }

      return response.data!;
    } on CoreException {
      rethrow;
    } catch (e) {
      throw CoreException.nullReferenceException(
        errorMessage ?? e.toString(),
        null,
      );
    }
  }
}
