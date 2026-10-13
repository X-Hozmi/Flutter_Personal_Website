import 'package:flutter/widgets.dart';
import 'package:flutter_personal_website/presentation/pages/blog/blog_page.dart';
import 'package:flutter_personal_website/presentation/pages/home/home_page.dart';
import 'package:flutter_personal_website/presentation/pages/navigation/navigation_page.dart';
import 'package:flutter_personal_website/presentation/pages/project/project_page.dart';
import 'package:flutter_personal_website/presentation/pages/unknown_page.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: Routes.homePage,
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'home',
              path: Routes.homePage,
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'project',
              path: Routes.projectPage,
              builder: (context, state) => ProjectPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'blog',
              path: Routes.blogPage,
              builder: (context, state) => BlogPage(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const UnknownPage(),
);
