import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_logger/logger.dart';
import 'package:config/config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import './rest_client.dart';
import './token/dtos/auth_token_dto.dart';
import './token/itoken_service.dart';

@Singleton(as: IRestClient)
class RestClient implements IRestClient {
  bool _isRefreshing = false;
  final List<Map<String, dynamic>> _failedRequests = [];

  RestClient(this._tokenService) {
    final options = BaseOptions(
      baseUrl: Env.of().endpoint,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    );

    // Plain Dio with no interceptors, used only for the refresh call itself.
    // If `/auth/refresh` reused `_dio`, a 401 from `/auth/refresh` would
    // re-enter this same error interceptor and hang forever waiting on
    // itself (queued in `_failedRequests`, never resolved/rejected).
    _refreshDio = Dio(options);

    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          logger.i(
            'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}',
          );
          final accessToken = await _tokenService.getAccessToken();
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';

          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },

        onResponse: (response, handler) {
          logger.d(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
          );
          handler.next(response);
        },

        onError: (err, handler) async {
          logger.e(
            'ERROR ### ===> ### [${err.response?.statusCode}] => PATH: ${err.response?.requestOptions.baseUrl}${err.response?.requestOptions.path}',
          );

          if (err.response?.statusCode != HttpStatus.unauthorized) {
            return handler.next(err);
          }

          // Check refresh token có tồn tại không
          final refreshToken = await _tokenService.getRefreshToken() ?? '';
          if (refreshToken.isEmpty) {
            return handler.reject(err);
          }

          // Nếu đang refresh thì queue request lại
          if (_isRefreshing) {
            _failedRequests.add({'err': err, 'handler': handler});
            return;
          }

          // Bắt đầu refresh
          _isRefreshing = true;

          final newAccessToken = await _refreshToken();

          if (newAccessToken != null) {
            // Refresh thành công → retry request hiện tại
            await _retryRequests(newAccessToken);

            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newAccessToken';
            return handler.resolve(await _dio.fetch(options));
          } else {
            // Refresh thất bại (token đã rotate/hết hạn) → đá ra login
            await _handleLogout(err, handler);
          }
        },
      ),
    );
  }

  late final Dio _dio;
  late final Dio _refreshDio;
  final ITokenService _tokenService;

  Future<void> _handleLogout(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Clear tất cả failed requests
    for (final request in _failedRequests) {
      final failedHandler = request['handler'] as ErrorInterceptorHandler;
      failedHandler.reject(request['err'] as DioException);
    }
    _failedRequests.clear();

    // Clear token và đá ra login
    await _tokenService.clearToken();

    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _tokenService.getRefreshToken();

      final response = await _refreshDio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final tokens = AuthTokenDto.fromJson(
          response.data?['data'] as Map<String, dynamic>,
        );

        // Refresh token rotation: cũ không dùng lại được, phải lưu đè cả hai.
        await _tokenService.saveToken(tokens.accessToken, tokens.refreshToken);

        return tokens.accessToken;
      }

      return null;
    } on DioException catch (e) {
      logger.e('Refresh token failed: ${e.response?.statusCode}');
      return null;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _retryRequests(String newAccessToken) async {
    final requests = List<Map<String, dynamic>>.from(_failedRequests);
    _failedRequests.clear();

    for (final request in requests) {
      final err = request['err'] as DioException;
      final handler = request['handler'] as ErrorInterceptorHandler;

      try {
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newAccessToken';
        handler.resolve(await _dio.fetch(options));
      } on DioException catch (e) {
        handler.reject(e);
      }
    }
  }

  @override
  Future<Response<dynamic>?> delete(String path, String? dataPrams) {
    return _dio.delete(path);
  }

  @override
  Future<Response<dynamic>?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response<dynamic>?> post(String path, String? dataPrams) {
    return _dio.post(path, data: dataPrams);
  }

  @override
  Future<Response<dynamic>> put(String path, String? dataPrams) {
    return _dio.put(path, data: dataPrams);
  }
}
