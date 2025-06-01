part of '../navigation_page.dart';

Widget buildNavItem(
  BuildContext context,
  NavigationController navigationController,
  ThemeController themeController,
  List<NavigationItem> navigationItems,
  String title,
  int index, {
  bool isMobile = false,
}) {
  return Obx(() {
    final isSelected = navigationController.tabIndex.value == index;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor =
        themeController.isDarkMode ? Colors.white70 : Colors.black54;

    return GestureDetector(
      onTap: () {
        // Navigate using both NavigationController and GoRouter
        if (navigationController.tabIndex.value != index) {
          navigationController.changeTabIndex(index);
          final navigationItem = navigationItems[index];
          context.goNamed(navigationItem.routeName);
          log(
            'Navigating to: ${navigationItem.routeName} (${navigationItem.routePath})',
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 12,
          vertical: isMobile ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withValues(alpha: 0.1) : null,
          borderRadius: BorderRadius.circular(6),
          border:
              isSelected
                  ? Border.all(color: primaryColor.withValues(alpha: 0.3))
                  : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? primaryColor : textColor,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            fontSize: isMobile ? 14 : 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  });
}
