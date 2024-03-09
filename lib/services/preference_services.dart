// En el archivo preferences_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static ThemeData getTheme() {
    final bool isDarkMode = _preferences.getBool('isDarkMode') ?? false;
    return isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  static Future<void> setTheme(bool isDarkMode) async {
    await _preferences.setBool('isDarkMode', isDarkMode);
  }

  static String getLanguage() {
    return _preferences.getString('language') ?? 'English';
  }

  static Future<void> setLanguage(String language) async {
    await _preferences.setString('language', language);
  }
}
