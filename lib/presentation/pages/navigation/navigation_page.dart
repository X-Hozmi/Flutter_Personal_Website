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

    return Scaffold(
      body: Column(
        children: [
          // Top Navigation
          const SizedBox(height: 20),
          Container(
            // width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              constraints: const BoxConstraints(maxWidth: 650),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Name
                  Obx(() {
                    switch (profileController.state) {
                      case RequestState.loading:
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF58A6FF),
                          ),
                        );

                      case RequestState.loaded:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      profileController
                                          .gitHubProfile!
                                          .avatarUrl,
                                  placeholder:
                                      (context, url) => Container(
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                  fit: BoxFit.cover,
                                  httpHeaders: gitHubAPIHeaders,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.broken_image,
                                            color: Color.fromRGBO(
                                              0,
                                              107,
                                              179,
                                              1,
                                            ),
                                            size: 24,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Tidak ada gambar',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              profileController.gitHubProfile!.name,
                              style: TextStyle(
                                // color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        );

                      default:
                        return const SizedBox.shrink();
                    }
                  }),
                  const Spacer(),
                  Row(
                    children: [
                      ..._navigationItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index < _navigationItems.length - 1 ? 20 : 0,
                          ),
                          child: _buildNavItem(item.title, index),
                        );
                      }),
                      const SizedBox(width: 20),
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            themeController.toggleTheme();
                            log(
                              'Theme toggled to: ${themeController.isDarkMode ? "Dark" : "Light"}',
                            );
                          },
                          icon: Icon(
                            themeController.isDarkMode
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color:
                                themeController.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                          ),
                          tooltip:
                              themeController.isDarkMode
                                  ? 'Switch to Light Mode'
                                  : 'Switch to Dark Mode',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Page Content
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: widget.screen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
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
            final navigationItem = _navigationItems[index];
            context.goNamed(navigationItem.routeName);
            log(
              'Navigating to: ${navigationItem.routeName} (${navigationItem.routePath})',
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            ),
          ),
        ),
      );
    });
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
