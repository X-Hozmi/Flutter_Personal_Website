import 'package:flutter/material.dart';
import 'package:flutter_personal_website/domain/entities/certificate.dart';
import 'package:flutter_personal_website/domain/entities/profile/github_profile.dart';
import 'package:flutter_personal_website/presentation/controllers/discord_presence_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/profile_controller.dart';
import 'package:flutter_personal_website/presentation/pages/home/parts/section_heading.dart';
import 'package:flutter_personal_website/presentation/widgets/info_card.dart';
import 'package:flutter_personal_website/presentation/widgets/portfolio_project_card.dart';
import 'package:flutter_personal_website/presentation/widgets/remote_image.dart';
import 'package:flutter_personal_website/presentation/widgets/scrollable_page.dart';
import 'package:flutter_personal_website/utils/cv_data.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:flutter_personal_website/utils/url_launch.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

part 'parts/hero_section.dart';
part 'parts/about_section.dart';
part 'parts/research_section.dart';
part 'parts/skills_section.dart';
part 'parts/experience_section.dart';
part 'parts/education_section.dart';
part 'parts/certificates_section.dart';
part 'parts/contact_section.dart';
part 'parts/discord_presence_section.dart';

/// Landing page built from static CV data.
///
/// Only the avatar and GitHub bio come from the GitHub API, so the page
/// renders immediately and stays complete even when GitHub is unreachable.
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final DiscordPresenceController discordController =
      Get.find<DiscordPresenceController>();

  @override
  Widget build(BuildContext context) {
    return ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => HeroSection(profile: _loadedProfile)),
          const SizedBox(height: 40),
          const SectionHeading(title: 'About'),
          Obx(() => AboutSection(profile: _loadedProfile)),
          const SizedBox(height: 40),
          const SectionHeading(title: 'Experience'),
          const ExperienceSection(),
          const SizedBox(height: 40),
          const SectionHeading(
            title: 'Research',
            subtitle: CvData.researchFocus,
          ),
          const ResearchSection(),
          const SizedBox(height: 40),
          const SectionHeading(title: 'Education'),
          const EducationSection(),
          const SizedBox(height: 40),
          const SectionHeading(title: 'Skills'),
          const SkillsSection(),
          const SizedBox(height: 40),
          const SectionHeading(
            title: 'Certificates',
            subtitle: 'Completed courses, with verification links.',
          ),
          const CertificatesSection(),
          const SizedBox(height: 40),
          const SectionHeading(title: 'Now Playing'),
          DiscordPresenceSection(controller: discordController),
          const SizedBox(height: 48),
          const ContactSection(),
        ],
      ),
    );
  }

  GitHubProfile? get _loadedProfile =>
      profileController.state == RequestState.loaded
          ? profileController.gitHubProfile
          : null;
}
