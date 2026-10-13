part of '../home_page.dart';

/// Work experience entries from the CV data.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final experience in CvData.workExperiences)
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithPeriod(
                  title: experience.role,
                  period: experience.period,
                ),
                const SizedBox(height: 4),
                Text(
                  '${experience.company} • ${experience.location}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                BulletList(items: experience.achievements),
              ],
            ),
          ),
      ],
    );
  }
}
