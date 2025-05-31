import 'package:flutter/widgets.dart';
import 'package:flutter_personal_website/presentation/controllers/navigation_controller.dart';
import 'package:flutter_personal_website/presentation/pages/blog/blog_page.dart';
import 'package:flutter_personal_website/presentation/pages/home/home_page.dart';
import 'package:flutter_personal_website/presentation/pages/navigation/navigation_page.dart';
import 'package:flutter_personal_website/presentation/pages/project/project_page.dart';
import 'package:flutter_personal_website/presentation/pages/unknown_page.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: Routes.homePage,
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    ShellRoute(
      /// A navigator key to manage nested navigation within the shell.
      navigatorKey: GlobalKey<NavigatorState>(),

      /// The shell's builder that wraps child pages.
      builder: (context, state, child) {
        return GetBuilder<NavigationController>(
          /// Provides a [NavigationCubit] to manage navigation state within the shell.
          init: NavigationController(),

          /// Handles user activity timeouts and renders the child navigation page.
          builder: (_) {
            return NavigationPage(screen: child);
          },
        );
      },

      /// Nested routes within the shell.
      routes: [
        /// Route for the home page.
        GoRoute(
          name: 'home', // Named route for identification.
          path: Routes.homePage, // URL path for the home page.
          builder: (context, state) => HomePage(), // Widget to display.
        ),

        /// Route for the project page.
        GoRoute(
          name: 'project', // Named route for identification.
          path: Routes.projectPage, // URL path for the project page.
          builder: (context, state) => ProjectPage(), // Widget to display.
        ),

        /// Route for the blog page.
        GoRoute(
          name: 'blog', // Named route for identification.
          path: Routes.blogPage, // URL path for the blog page.
          builder: (context, state) => BlogPage(), // Widget to display.
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const UnknownPage(),
);
