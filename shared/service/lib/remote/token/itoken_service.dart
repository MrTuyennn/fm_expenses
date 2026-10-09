const accessTokenSecretKey = 'accessTokenSecretKey@RestClient';
const refreshAccessTokenSecretKey = 'refreshAccessTokenSecretKey@RestClient';

abstract interface class ITokenService {
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> saveToken(String accessToken, String refreshToken);

  /// Clears stored tokens and fires [onLoggedOut] — called both when the
  /// user explicitly logs out and when a refresh-token attempt fails (token
  /// expired/revoked), so the UI can always react by routing to login.
  Future<void> clearToken();

  /// Fires whenever [clearToken] runs, regardless of the reason.
  Stream<void> get onLoggedOut;
}
