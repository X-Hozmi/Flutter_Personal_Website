import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/controllers/discord_presence_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/profile_controller.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:flutter_personal_website/utils/url_launch.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20),
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
                    const SizedBox(height: 40),
                    // Profile Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

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
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isWideScreen = constraints.maxWidth > 600;
                          final imageSize = isWideScreen ? 150.0 : 120.0;

                          if (isWideScreen) {
                            // Desktop/Tablet layout - Row
                            return desktopLayout(profileController, imageSize);
                          } else {
                            // Mobile layout - Column
                            return mobileLayout(profileController, imageSize);
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Discord Presence (placeholder)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Discord Presence',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Obx(() {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
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
                    const SizedBox(height: 30),

                    // About Section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'A little about me',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      profileController.gitHubProfile!.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        // color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // CTA Button
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed('project');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D8FF),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Check out all projects',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
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
}
