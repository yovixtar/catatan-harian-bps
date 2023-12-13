import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final String responseDataKey = 'responseData';

  static Future<bool> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(responseDataKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(responseDataKey);
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }

  static Future<bool> saveData(Map<String, dynamic> responseData) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(responseDataKey, json.encode(responseData));
  }

  static Future<Map<String, dynamic>?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final responseDataString = prefs.getString(responseDataKey);
    if (responseDataString == null) {
      return null;
    }
    return json.decode(responseDataString);
  }
}
