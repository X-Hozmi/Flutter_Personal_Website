part of '../home_page.dart';

/// Research interests, research experience, and publications.
///
/// Intentionally omits statistical results until the final figures are
/// confirmed against the published manuscript.
class ResearchSection extends StatelessWidget {
  const ResearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Interests', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final interest in CvData.researchInterests)
              Chip(label: Text(interest), visualDensity: VisualDensity.compact),
          ],
        ),
        const SizedBox(height: 20),
        for (final research in CvData.researchExperiences) ...[
          PortfolioProjectCard(project: research),
          const SizedBox(height: 16),
        ],
        Text('Publications', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final publication in CvData.publications)
          InfoCard(
            padding: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithPeriod(
                  title: publication.title,
                  period: publication.period,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  publication.authors,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  publication.status,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
