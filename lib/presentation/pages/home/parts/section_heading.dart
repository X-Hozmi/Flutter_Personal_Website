import 'package:flutter/material.dart';

/// A consistent section heading with an optional subtitle.
class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Container(
          width: 48,
          height: 4,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
