import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_personal_website/injection.dart' as di;
import 'package:flutter_personal_website/app_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return GetMaterialApp.router(
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
      title: 'Abdillah Haidar',
      debugShowCheckedModeBanner: false,
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      themeMode: themeController.themeMode,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      routeInformationProvider: goRouter.routeInformationProvider,
    );
  }
}
