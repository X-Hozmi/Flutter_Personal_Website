import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/controllers/theme_controller.dart';
import 'package:flutter_personal_website/presentation/widgets/scrollable_page.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Persistent application shell rendered around every routed page.
///
/// Contains the top navigation bar. Each page provides its own scroll view
/// via `ScrollablePage`. On mobile the navigation collapses to icons.
class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: isMobile ? 10 : 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: ScrollablePage.maxContentWidth,
                ),
                child: _TopNavBar(
                  themeController: themeController,
                  currentIndex: navigationShell.currentIndex,
                  onSelected: _goBranch,
                  isMobile: isMobile || isTablet,
                ),
              ),
            ),
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _TopNavBar extends StatelessWidget {
  const _TopNavBar({
    required this.themeController,
    required this.currentIndex,
    required this.onSelected,
    required this.isMobile,
  });

  final ThemeController themeController;
  final int currentIndex;
  final ValueChanged<int> onSelected;
  final bool isMobile;

  static const _navItems = <({String label, IconData icon})>[
    (label: 'Home', icon: Icons.home_outlined),
    (label: 'Projects', icon: Icons.folder_outlined),
    (label: 'Blog', icon: Icons.article_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 12,
        vertical: isMobile ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
            child: Text(
              'AH',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: colors.primary,
              ),
            ),
          ),
          const Spacer(),
          ..._navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final selected = index == currentIndex;

            return _NavChip(
              label: item.label,
              icon: item.icon,
              selected: selected,
              isMobile: isMobile,
              onTap: () => onSelected(index),
            );
          }),
          SizedBox(width: isMobile ? 4 : 8),
          Obx(
            () => IconButton(
              tooltip:
                  themeController.isDarkMode
                      ? 'Switch to light mode'
                      : 'Switch to dark mode',
              onPressed: themeController.toggleTheme,
              icon: Icon(
                themeController.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavChip extends StatelessWidget {
  const _NavChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.isMobile,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final bool isMobile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(right: isMobile ? 2 : 6),
      child: Tooltip(
        message: label,
        child: Semantics(
          button: true,
          selected: selected,
          label: label,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 14,
                vertical: isMobile ? 6 : 8,
              ),
              decoration: BoxDecoration(
                color:
                    selected
                        ? colors.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: isMobile ? 16 : 18,
                    color: selected ? colors.primary : colors.onSurfaceVariant,
                  ),
                  if (!isMobile) ...[
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        color:
                            selected ? colors.primary : colors.onSurfaceVariant,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
