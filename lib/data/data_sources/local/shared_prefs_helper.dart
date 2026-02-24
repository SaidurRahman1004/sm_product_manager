import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _prefs;

  //save Token or user idkey
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //save Token
  static Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  //get Token
  static String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  //save userId
  static Future<bool> saveUserId(String userId) async {
    return await _prefs.setString(_userIdKey, userId);
  }
  //get userId
  static String? getUserId() {
    return _prefs.getString(_userIdKey);
  }
  //remove Token logout
  static Future<void> removeToken() async {
    await _prefs.remove(_tokenKey);
  }
}
