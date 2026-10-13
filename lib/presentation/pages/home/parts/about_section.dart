part of '../home_page.dart';

/// About section combining the GitHub bio with the CV about paragraph.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.profile});

  final GitHubProfile? profile;

  @override
  Widget build(BuildContext context) {
    final bio = profile?.bio;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bio != null && bio.isNotEmpty) ...[
            Text(
              bio,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            CvData.about,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
