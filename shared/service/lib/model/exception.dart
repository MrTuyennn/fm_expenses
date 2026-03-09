import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:dio/dio.dart';

part 'exception.type.dart';

class CoreException implements Exception {
  CoreException._({required this.type, this.message, this.serverCode});

  factory CoreException(Exception? error) {
    CoreExceptionType type;
    String? message;
    int? serverCode;
    if (error is CoreException) return error;

    if (error is DioException) {
      // message =
      //     ServerTalkUtils.getMessage(
      //       locale: error.requestOptions.headers['language'],
      //       code: error.response?.data?['error_code'],
      //     ) ??
      //     error.response?.statusMessage ??
      //     error.message;
      serverCode = error.response?.statusCode;

      switch (error.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            // SocketException: Failed host lookup: '***'
            // (OS Error: No address associated with hostname, errno = 7)
            type = CoreExceptionType.network;
            message = 'Oh no, look like we lost connection';
          } else {
            type = CoreExceptionType.unknown;
          }
          break;
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          type = CoreExceptionType.timeout;
          break;
        case DioExceptionType.sendTimeout:
          type = CoreExceptionType.network;
          break;
        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case HttpStatus.badRequest: // 400
              type = CoreExceptionType.badRequest;
              break;
            case HttpStatus.unauthorized: // 401
              type = CoreExceptionType.unauthorized;
              break;
            case HttpStatus.locked: //423
              type = CoreExceptionType.locked;
              break;
            case HttpStatus.internalServerError: // 500
            case HttpStatus.badGateway: // 502
            case HttpStatus.gatewayTimeout: // 504
              type = CoreExceptionType.server;
              break;
            case HttpStatus.httpVersionNotSupported: // 505
              type = CoreExceptionType.versionNotSupported;
              break;
            case HttpStatus.serviceUnavailable: // 503
              type = CoreExceptionType.serverMaintenance;
              break;

            default:
              type = CoreExceptionType.unknown;
              break;
          }

          break;
        case DioExceptionType.cancel:
          type = CoreExceptionType.cancel;
          break;
        default:
          type = CoreExceptionType.unknown;
      }
    } else {
      type = CoreExceptionType.unknown;
      message = error.toString().replaceAll('Exception: ', '');
    }

    return CoreException._(
      type: type,
      message: message,
      serverCode: serverCode,
    );
  }
  factory CoreException.nullReferenceException([
    String? message,
    int? serverCode,
  ]) {
    return CoreException._(
      type: CoreExceptionType.nullReferenceException,
      message: message,
      serverCode: serverCode,
    );
  }

  final String? message;
  final CoreExceptionType type;
  final int? serverCode;

  @override
  String toString() {
    return '[${type.name.toUpperCase()}] $message';
  }
}
