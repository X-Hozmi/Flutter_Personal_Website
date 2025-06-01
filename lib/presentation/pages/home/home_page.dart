import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/controllers/discord_presence_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/profile_controller.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:flutter_personal_website/utils/url_launch.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

part 'parts/build_discord_presence_content.dart';
part 'parts/desktop_layout.dart';
part 'parts/mobile_layout.dart';
part 'parts/get_presence_status_text.dart';
part 'parts/get_status_color.dart';
part 'parts/build_spotify_section.dart';
part 'parts/build_activity_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final DiscordPresenceController discordController =
      Get.find<DiscordPresenceController>();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            switch (profileController.state) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF58A6FF)),
                );

              case RequestState.error:
                return Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${profileController.message}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed:
                            () => profileController.refreshGitHubProfile(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF58A6FF),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );

              case RequestState.empty:
                return Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.folder_open,
                        color: Colors.grey,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profileController.message,
                        style: const TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );

              case RequestState.loaded:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: isMobile ? 20 : 40),
                    // Profile Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isMobile ? 12 : 16),
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
                      child: Text(
                        greeting,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                          fontSize: isMobile ? 14 : 16,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 30),

                    // Responsive Profile Section
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap:
                          () => urlLauncher(
                            Uri.parse(profileController.gitHubProfile!.htmlUrl),
                          ),
                      child: _buildResponsiveProfileLayout(context),
                    ),

                    SizedBox(height: isMobile ? 15 : 20),

                    // Discord Presence
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Discord Presence',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 10 : 15),

                    Obx(() {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(isMobile ? 12 : 16),
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
                        child: buildDiscordPresenceContent(
                          context,
                          discordController,
                        ),
                      );
                    }),
                    SizedBox(height: isMobile ? 20 : 30),

                    // About Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'A little about me',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 10 : 15),
                    Text(
                      profileController.gitHubProfile!.bio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 30),

                    // CTA Button
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed('project');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D8FF),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 24,
                          vertical: isMobile ? 10 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isMobile
                                ? 'View Projects'
                                : 'Check out all projects',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: isMobile ? 14 : 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: isMobile ? 16 : 18),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 30 : 40),
                  ],
                );

              default:
                return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildResponsiveProfileLayout(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    // Determine image size based on screen size
    double imageSize;
    if (isDesktop) {
      imageSize = 150.0;
    } else if (isTablet) {
      imageSize = 130.0;
    } else {
      imageSize = 120.0;
    }

    if (isMobile) {
      return mobileLayout(profileController, imageSize);
    } else {
      return desktopLayout(profileController, imageSize);
    }
  }
}
