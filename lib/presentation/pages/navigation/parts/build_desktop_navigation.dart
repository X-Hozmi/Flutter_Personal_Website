part of '../navigation_page.dart';

Widget buildDesktopNavigation(
  BuildContext context,
  NavigationController navigationController,
  ProfileController profileController,
  ThemeController themeController,
  List<NavigationItem> navigationItems,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Logo/Name
      Flexible(flex: 2, child: buildProfileSection(context, profileController)),
      // Navigation Items + Theme Toggle
      Flexible(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...navigationItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  right: index < navigationItems.length - 1 ? 20 : 0,
                ),
                child: buildNavItem(
                  context,
                  navigationController,
                  themeController,
                  navigationItems,
                  item.title,
                  index,
                ),
              );
            }),
            const SizedBox(width: 20),
            buildThemeToggle(themeController),
          ],
        ),
      ),
    ],
  );
}
