import 'package:flutter/material.dart';
import 'package:flutter_personal_website/domain/entities/blog/blog.dart';
import 'package:flutter_personal_website/presentation/controllers/blog_controller.dart';
import 'package:flutter_personal_website/presentation/pages/home/parts/section_heading.dart';
import 'package:flutter_personal_website/presentation/widgets/scrollable_page.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:flutter_personal_website/presentation/widgets/remote_image.dart';
import 'package:flutter_personal_website/utils/url_launch.dart';
import 'package:get/get.dart';

class BlogPage extends StatelessWidget {
  BlogPage({super.key});

  final BlogController blogController = Get.find<BlogController>();

  @override
  Widget build(BuildContext context) {
    return ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            title: 'Blog',
            subtitle:
                'Writing about backend engineering, infrastructure, '
                'and the occasional Flutter detour.',
          ),
          const SizedBox(height: 8),
          Obx(() {
            switch (blogController.state) {
              case RequestState.initial || RequestState.loading:
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              case RequestState.error:
                return _ErrorView(
                  message: blogController.message,
                  onRetry: blogController.refreshBlogs,
                );
              case RequestState.empty:
                return _EmptyView(message: blogController.message);
              case RequestState.loaded:
                return _BlogList(blogs: blogController.blogs);
            }
          }),
        ],
      ),
    );
  }
}

class _BlogList extends StatelessWidget {
  const _BlogList({required this.blogs});

  final List<Blog> blogs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final blog in blogs) _BlogCard(blog: blog),
      ],
    );
  }
}

class _BlogCard extends StatelessWidget {
  const _BlogCard({required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => urlLauncher(Uri.parse(blog.guid)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.thumbnail != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: RemoteImage(
                  url: blog.thumbnail!,
                  width: 72,
                  height: 72,
                  fallback: ColoredBox(
                    color: colors.surfaceContainerHighest,
                    child: const Icon(Icons.article_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatDate(blog.pubDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  if (blog.categories.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final category in blog.categories.take(4))
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: colors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year}';
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(Icons.edit_note, size: 48, color: colors.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            'New posts will show up here automatically once published.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

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
