import 'package:injectable/injectable.dart';
import 'package:storage/storage.dart';

import './itoken_service.dart';

@Singleton(as: ITokenService)
class TokenService implements ITokenService {
  TokenService();

  @override
  Future<void> clearToken() {
    final secureStorage = Storage.instance.secureStorage;
    return Future.wait([
      secureStorage.delete(key: accessTokenSecretKey),
      secureStorage.delete(key: refreshAccessTokenSecretKey),
    ]);
  }

  @override
  Future<String?> getAccessToken() async {
    final secureStorage = Storage.instance.secureStorage;
    final accessToken = await secureStorage.read(key: accessTokenSecretKey);
    return accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final secureStorage = Storage.instance.secureStorage;
    final refreshAccessToken = await secureStorage.read(
      key: refreshAccessTokenSecretKey,
    );
    return refreshAccessToken;
  }

  @override
  Future<void> saveToken(String accessToken, String refreshToken) {
    final secureStorage = Storage.instance.secureStorage;
    return Future.wait([
      secureStorage.write(key: accessTokenSecretKey, value: accessToken),
      secureStorage.write(
        key: refreshAccessTokenSecretKey,
        value: refreshToken,
      ),
    ]);
  }
}
