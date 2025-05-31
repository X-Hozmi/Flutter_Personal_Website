part of '../home_page.dart';

Widget buildActivitiesSection(
  BuildContext context,
  DiscordPresenceController discordController,
) {
  final nonSpotifyActivities =
      discordController.activities
          .where((activity) => activity.name != 'Spotify')
          .toList();

  if (nonSpotifyActivities.isEmpty) return const SizedBox.shrink();

  final activity = nonSpotifyActivities.first;

  return Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${activity.activityType} ${activity.name}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (activity.details != null) ...[
          const SizedBox(height: 2),
          Text(
            activity.details!,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (activity.state != null) ...[
          const SizedBox(height: 2),
          Text(
            activity.state!,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    ),
  );
}
