import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/controllers/navigation_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/profile_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/theme_controller.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

part 'parts/build_desktop_navigation.dart';
part 'parts/build_mobile_navigation.dart';
part 'parts/build_nav_item.dart';
part 'parts/build_profile_section.dart';
part 'parts/build_theme_toggle.dart';

class NavigationPage extends StatefulWidget {
  final Widget screen;

  const NavigationPage({super.key, required this.screen});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final NavigationController navigationController =
      Get.find<NavigationController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ThemeController themeController = Get.find<ThemeController>();

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: 'Home',
      routeName: 'home',
      routePath: Routes.homePage,
    ),
    NavigationItem(
      title: 'Projects',
      routeName: 'project',
      routePath: Routes.projectPage,
    ),
    NavigationItem(
      title: 'Blog',
      routeName: 'blog',
      routePath: Routes.blogPage,
    ),
  ];

  void _updateNavigationController(String location) {
    for (int i = 0; i < _navigationItems.length; i++) {
      if (location == _navigationItems[i].routePath) {
        if (navigationController.tabIndex.value != i) {
          navigationController.changeTabIndex(i);
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    log('Current Location: $location');

    _updateNavigationController(location);

    if (profileController.gitHubProfile == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        profileController.getGitHubProfile();
      });
    }

    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Scaffold(
      body: Column(
        children: [
          // Top Navigation
          SizedBox(height: isMobile ? 10 : 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 20,
              vertical: isMobile ? 10 : 15,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF30363D)
                        : Colors.grey.shade300,
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 650 : (isTablet ? 550 : double.infinity),
              ),
              child:
                  isMobile || isTablet
                      ? buildMobileNavigation(
                        context,
                        navigationController,
                        profileController,
                        themeController,
                        _navigationItems,
                      )
                      : buildDesktopNavigation(
                        context,
                        navigationController,
                        profileController,
                        themeController,
                        _navigationItems,
                      ),
            ),
          ),
          // Page Content
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        isDesktop ? 650 : (isTablet ? 550 : double.infinity),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 20,
                    ),
                    child: widget.screen,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final String routeName;
  final String routePath;

  NavigationItem({
    required this.title,
    required this.routeName,
    required this.routePath,
  });
}
