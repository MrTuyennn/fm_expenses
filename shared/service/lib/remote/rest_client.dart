import 'package:dio/dio.dart';

import 'rest_interceptors_client.dart';

typedef IRestClientOptions = BaseOptions;

class IBaseRestClient with DioMixin implements Dio {
  static final IBaseRestClient _instance = IBaseRestClient();
  static IBaseRestClient get instance => _instance;
  late Dio _dio;

  IBaseRestClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://hf-tau.vercel.app/api',
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: Headers.formUrlEncodedContentType,
    );

    _dio = Dio(options);
    _dio.interceptors.add(RestInterceptorsClient());
  }

  IRestClientOptions get defaultOptions => IRestClientOptions(
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    contentType: 'application/json; charset=utf-8',
  );

  void onDispose({Object? reason}) {
    // clean token
    // _defaultCancelToken.cancel(reason);
  }
}
