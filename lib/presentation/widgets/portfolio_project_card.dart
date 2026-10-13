import 'package:flutter/material.dart';
import 'package:flutter_personal_website/domain/entities/portfolio_project.dart';
import 'package:flutter_personal_website/presentation/widgets/info_card.dart';
import 'package:flutter_personal_website/utils/url_launch.dart';

/// Card for a curated project or research entry with its CV highlights.
class PortfolioProjectCard extends StatelessWidget {
  const PortfolioProjectCard({super.key, required this.project});

  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final url = project.url;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWithPeriod(
            title: project.name,
            period: project.period,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            project.summary,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          BulletList(items: project.highlights),
          if (url != null)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => urlLauncher(Uri.parse(url)),
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('View repository'),
              ),
            ),
        ],
      ),
    );
  }
}
