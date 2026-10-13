part of '../home_page.dart';

/// Renders grouped skill chips from the CV data.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = [
      ...CvData.skillGroups.entries,
      const MapEntry('Soft Skills', CvData.softSkills),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in entries) ...[
          Text(
            entry.key,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final skill in entry.value)
                Chip(
                  label: Text(skill),
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
