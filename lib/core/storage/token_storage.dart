import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final SharedPreferences _prefs;

  const TokenStorage(this._prefs);

  String? get accessToken => _prefs.getString(_accessTokenKey);
  String? get refreshToken => _prefs.getString(_refreshTokenKey);
  bool get hasTokens => accessToken != null;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    await _prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<void> clearTokens() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
  }
}
