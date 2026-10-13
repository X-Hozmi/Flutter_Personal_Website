import 'package:flutter/material.dart';
import 'package:flutter_personal_website/domain/entities/github_repo.dart';
import 'package:flutter_personal_website/presentation/controllers/project_controller.dart';
import 'package:flutter_personal_website/presentation/pages/home/parts/section_heading.dart';
import 'package:flutter_personal_website/presentation/pages/project/parts/github_repo_card.dart';
import 'package:flutter_personal_website/presentation/widgets/portfolio_project_card.dart';
import 'package:flutter_personal_website/presentation/widgets/scrollable_page.dart';
import 'package:flutter_personal_website/utils/cv_data.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:get/get.dart';

/// Featured projects from the CV followed by public GitHub repositories.
class ProjectPage extends StatelessWidget {
  ProjectPage({super.key});

  final ProjectController projectController = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    return ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            title: 'Projects',
            subtitle:
                'Selected work, followed by my public GitHub repositories.',
          ),
          const SizedBox(height: 8),
          Text('Featured', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          for (final project in CvData.featuredProjects) ...[
            PortfolioProjectCard(project: project),
            const SizedBox(height: 16),
          ],
          const SizedBox(height: 16),
          Text(
            'GitHub repositories',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Obx(
            () => switch (projectController.state) {
              RequestState.initial || RequestState.loading => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              ),
              RequestState.error => _ErrorState(
                message: projectController.message,
                onRetry: projectController.refreshProjects,
              ),
              RequestState.empty => Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  projectController.message,
                  textAlign: TextAlign.center,
                ),
              ),
              RequestState.loaded => _RepoGrid(
                repos: projectController.repos.toList(),
              ),
            },
          ),
        ],
      ),
    );
  }
}

/// Two-column layout on wide screens built from rows of intrinsic height, so
/// cards grow with their content instead of overflowing a fixed aspect ratio.
class _RepoGrid extends StatelessWidget {
  const _RepoGrid({required this.repos});

  final List<GitHubRepo> repos;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 700 ? 2 : 1;
        final rows = <List<GitHubRepo>>[
          for (var i = 0; i < repos.length; i += columns)
            repos.sublist(i, (i + columns).clamp(0, repos.length)),
        ];

        return Column(
          children: [
            for (final row in rows)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < columns; i++) ...[
                        if (i > 0) const SizedBox(width: 16),
                        Expanded(
                          child:
                              i < row.length
                                  ? GitHubRepoCard(repo: row[i])
                                  : const SizedBox.shrink(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 44),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
