import 'dart:io';

import 'package:app_logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import './rest_client.dart';
import './token/itoken_service.dart';
import 'token/dtos/refresh_token_response.dart';

@Singleton(as: IRestClient)
class RestClient implements IRestClient {
  RestClient(this._tokenService) {
    final options = BaseOptions(
      baseUrl: 'https://hf-tau.vercel.app/api/v1',
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    );

    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          logger.i(
            'REQUEST[${options.method}] => PATH: ${options.baseUrl}/${options.path}',
          );
          final accessToken = await _tokenService.getAccessToken();
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';

          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
        },

        onResponse: (response, handler) {
          logger.d(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
          );
        },

        onError: (err, handler) async {
          logger.e(
            'RESPONSE[${err.response?.statusCode}] => PATH: ${err.response?.requestOptions.baseUrl}${err.response?.requestOptions.path}',
          );
          if (err.response?.statusCode == HttpStatus.unauthorized) {
            final token = await _tokenService.getRefreshToken();

            try {
              final response = await _dio.post<Map<String, dynamic>>(
                '/api/v1/auth/refresh-token',
                data: {"refreshToken": token},
              );
              RefreshTokenResponse? refreshTokenResponse;
              if (response.statusCode == 200) {
                refreshTokenResponse = RefreshTokenResponse.fromJson(
                  response.data ?? {},
                );
              }

              final accesToken = refreshTokenResponse?.data.accessToken ?? '';
              final refreshToken =
                  refreshTokenResponse?.data.refreshToken ?? '';

              // save new access token and refresh token to secure storage
              await _tokenService.saveToken(accesToken, refreshToken);

              final options = err.requestOptions;

              // update request headers with new access token
              options.headers['Authorization'] = 'Bearer $accesToken';
              // repeat the request with new access token
              return handler.resolve(await _dio.fetch(options));
            } on DioException catch (e) {
              if (e.response?.statusCode == 498) {
                // remove access token and refresh token from secure storage
                await _tokenService.clearToken();

                return handler.next(err);
              }

              // continue with the error
              return handler.next(err);
            }
          }
          // continue with the error
          return handler.next(err);
        },
      ),
    );
  }

  late final Dio _dio;
  final ITokenService _tokenService;

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
