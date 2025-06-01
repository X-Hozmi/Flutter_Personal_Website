part of '../navigation_page.dart';

Widget buildMobileNavigation(
  BuildContext context,
  NavigationController navigationController,
  ProfileController profileController,
  ThemeController themeController,
  List<NavigationItem> navigationItems,
) {
  return Column(
    children: [
      // Top row with profile and theme toggle
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: buildProfileSection(context, profileController)),
          buildThemeToggle(themeController),
        ],
      ),
      const SizedBox(height: 15),
      // Navigation items
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            navigationItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Flexible(
                child: buildNavItem(
                  context,
                  navigationController,
                  themeController,
                  navigationItems,
                  item.title,
                  index,
                  isMobile: true,
                ),
              );
            }).toList(),
      ),
    ],
  );
}
