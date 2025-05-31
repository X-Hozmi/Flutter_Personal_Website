import 'package:flutter/material.dart';
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
        Get.changeTheme(_isDarkMode.value ? darkTheme : lightTheme);
        Get.changeThemeMode(
          _isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        );
      }
    } catch (e) {
      debugPrint('Error loading theme preference: $e');
    }
  }

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeTheme(_isDarkMode.value ? darkTheme : lightTheme);
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    await _saveThemeToPrefs();
  }

  Future<void> _saveThemeToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, _isDarkMode.value);
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }

  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  ThemeData get lightTheme => ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    // scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Warm bluish-white
    scaffoldBackgroundColor: const Color.fromRGBO(
      219,
      233,
      244,
      1,
    ), // Azureish white
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF1F5F9), // Slightly cooler than background
      elevation: 0,
      foregroundColor: Color(0xFF334155),
    ),
    cardColor: const Color(0xFFF1F5F9), // Soft blue-gray card background
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3B82F6), // Modern blue
      secondary: Color(0xFF06B6D4), // Cyan accent
      surface: Color(0xFFF1F5F9), // Soft blue-gray surface
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1E293B),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF334155)),
      bodyMedium: TextStyle(color: Color(0xFF475569)),
      titleLarge: TextStyle(color: Color(0xFF1E293B)),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0D1117),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF161B22),
      elevation: 0,
      foregroundColor: Colors.white,
    ),
    cardColor: const Color(0xFF161B22),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF58A6FF),
      secondary: Color(0xFF79C0FF),
      surface: Color(0xFF161B22),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
  );

  ThemeData get currentTheme => _isDarkMode.value ? darkTheme : lightTheme;
}
