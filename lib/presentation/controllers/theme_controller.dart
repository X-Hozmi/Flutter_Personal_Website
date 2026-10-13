import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'isDarkMode';

  final _isDarkMode = true.obs;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getBool(_themeKey);

      if (savedTheme != null) {
        _isDarkMode.value = savedTheme;
      }
    } catch (e) {
      debugPrint('Error loading theme preference: $e');
    }
  }

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, _isDarkMode.value);
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }

  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  ThemeData get theme => _isDarkMode.value ? AppTheme.dark : AppTheme.light;
  ThemeData get lightTheme => AppTheme.light;
  ThemeData get darkTheme => AppTheme.dark;
  ThemeData get currentTheme => theme;
}
