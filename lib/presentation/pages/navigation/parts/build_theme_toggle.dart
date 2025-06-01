part of '../navigation_page.dart';

Widget buildThemeToggle(ThemeController themeController) {
  return Obx(
    () => IconButton(
      onPressed: () {
        themeController.toggleTheme();
        log(
          'Theme toggled to: ${themeController.isDarkMode ? "Dark" : "Light"}',
        );
      },
      icon: Icon(
        themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: themeController.isDarkMode ? Colors.white70 : Colors.black54,
      ),
      tooltip:
          themeController.isDarkMode
              ? 'Switch to Light Mode'
              : 'Switch to Dark Mode',
    ),
  );
}
