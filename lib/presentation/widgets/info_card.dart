import 'package:flutter/material.dart';

/// Bordered surface card shared by the home and project sections.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.child, this.padding = 24});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: child,
    );
  }
}

/// A bullet list whose items wrap freely, so long text never overflows.
class BulletList extends StatelessWidget {
  const BulletList({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Icon(Icons.circle, size: 6, color: colors.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Title row with a period that moves under the title on narrow screens.
class TitleWithPeriod extends StatelessWidget {
  const TitleWithPeriod({
    super.key,
    required this.title,
    required this.period,
    this.style,
  });

  final String title;
  final String period;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final periodText = Text(
      period,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
    final titleText = Text(
      title,
      style: style ?? Theme.of(context).textTheme.titleLarge,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [titleText, const SizedBox(height: 2), periodText],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: titleText),
            const SizedBox(width: 12),
            periodText,
          ],
        );
      },
    );
  }
}
