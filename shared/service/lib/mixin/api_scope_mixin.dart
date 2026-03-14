import 'package:app_logger/logger.dart';
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
      logger.e(res);
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
    } on Exception catch (e) {
      // Chuyển các Exception khác (ví dụ DioException khi chưa parse) về CoreException chuẩn
      throw CoreException(e);
    }
  }
}
