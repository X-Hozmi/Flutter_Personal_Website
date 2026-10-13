part of '../home_page.dart';

/// Education entries from the CV data.
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final education in CvData.educations)
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithPeriod(
                  title: education.degree,
                  period: education.period,
                ),
                const SizedBox(height: 4),
                Text(
                  '${education.institution} • ${education.location}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (education.details.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  BulletList(items: education.details),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
