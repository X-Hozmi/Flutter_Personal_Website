import 'package:flutter/material.dart';
import 'package:flutter_personal_website/domain/entities/github_repo.dart';
import 'package:flutter_personal_website/utils/url_launch.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Repository card showing description, primary language, stars, forks, and
/// a homepage link when available.
///
/// Uses the `language` field from the repository listing instead of one
/// languages request per card, keeping the anonymous API budget small.
class GitHubRepoCard extends StatelessWidget {
  const GitHubRepoCard({super.key, required this.repo});

  final GitHubRepo repo;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return InkWell(
      onTap: () => urlLauncher(Uri.parse(repo.htmlUrl)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 14 : 18),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    repo.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                if (repo.homepage != null && repo.homepage!.isNotEmpty)
                  IconButton(
                    tooltip: 'Open website',
                    visualDensity: VisualDensity.compact,
                    onPressed: () => urlLauncher(Uri.parse(repo.homepage!)),
                    icon: const Icon(Icons.open_in_new, size: 18),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              repo.description.isNotEmpty
                  ? repo.description
                  : 'No description provided.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              maxLines: isMobile ? 3 : 4,
              overflow: TextOverflow.ellipsis,
            ),
            if (repo.language.isNotEmpty) ...[
              const SizedBox(height: 12),
              _LanguageChip(label: repo.language),
            ],
            const Spacer(),
            const SizedBox(height: 10),
            Row(
              children: [
                _Stat(icon: Icons.star_outline, value: repo.stargazersCount),
                const SizedBox(width: 14),
                _Stat(icon: Icons.call_split, value: repo.forksCount),
                const Spacer(),
                Icon(
                  Icons.arrow_outward,
                  size: 18,
                  color: colors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.primary.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value});

  final IconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          '$value',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
