part of '../home_page.dart';

/// Discord presence + Spotify + current activity, kept compact on mobile.
class DiscordPresenceSection extends StatelessWidget {
  const DiscordPresenceSection({super.key, required this.controller});

  final DiscordPresenceController controller;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Obx(
        () => switch (controller.state) {
          RequestState.initial ||
          RequestState.loading => const _CompactLoadingRow(),
          RequestState.error || RequestState.empty => _CompactError(
            onRetry: controller.refreshDiscordPresence,
          ),
          RequestState.loaded => _PresenceBody(controller: controller),
        },
      ),
    );
  }
}

class _CompactLoadingRow extends StatelessWidget {
  const _CompactLoadingRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 10),
        Text(
          'Loading Discord presence...',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _CompactError extends StatelessWidget {
  const _CompactError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Could not load Discord presence.',
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
        ),
        TextButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    );
  }
}

class _PresenceBody extends StatelessWidget {
  const _PresenceBody({required this.controller});

  final DiscordPresenceController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final user = controller.user;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    if (user == null) {
      return const Text('No Discord data available.');
    }

    return Column(
      children: [
        Row(
          children: [
            ClipOval(
              child: RemoteImage(
                url: user.avatarUrl,
                width: isMobile ? 32 : 40,
                height: isMobile ? 32 : 40,
                semanticLabel: 'Discord avatar',
                fallback: const ColoredBox(
                  color: Color(0xFF5865F2),
                  child: Icon(Icons.discord, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${user.effectiveName}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                  Text(
                    controller.getStatusDisplayText(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _statusColor(controller),
                shape: BoxShape.circle,
                border: Border.all(color: colors.surface, width: 2),
              ),
            ),
          ],
        ),
        if (controller.isListeningToSpotify &&
            controller.currentSpotify != null) ...[
          const SizedBox(height: 16),
          _SpotifyTile(controller: controller),
        ],
        if (controller.activities.isNotEmpty && !controller.isOffline) ...[
          const SizedBox(height: 12),
          _ActivityTile(controller: controller),
        ],
      ],
    );
  }

  Color _statusColor(DiscordPresenceController controller) {
    switch (controller.discordPresence?.discordStatus) {
      case 'online':
        return const Color(0xFF23A55A);
      case 'idle':
        return const Color(0xFFF0B232);
      case 'dnd':
        return const Color(0xFFF23F43);
      default:
        return const Color(0xFF80848E);
    }
  }
}

class _SpotifyTile extends StatelessWidget {
  const _SpotifyTile({required this.controller});

  final DiscordPresenceController controller;

  @override
  Widget build(BuildContext context) {
    final spotify = controller.currentSpotify!;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      padding: EdgeInsets.all(isMobile ? 10 : 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1DB954).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1DB954).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: RemoteImage(
              url: spotify.albumArtUrl,
              width: isMobile ? 36 : 44,
              height: isMobile ? 36 : 44,
              semanticLabel: 'Album art',
              fallback: ColoredBox(
                color: Colors.grey.shade300,
                child: const Icon(Icons.music_note),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Listening to Spotify',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF1DB954),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  spotify.song,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'by ${spotify.artist}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.controller});

  final DiscordPresenceController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final nonSpotifyActivities =
        controller.activities
            .where((activity) => activity.name != 'Spotify')
            .toList();

    if (nonSpotifyActivities.isEmpty) return const SizedBox.shrink();

    final activity = nonSpotifyActivities.first;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${activity.activityType} ${activity.name}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: colors.primary,
            ),
          ),
          if (activity.details != null) ...[
            const SizedBox(height: 4),
            Text(
              activity.details!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          if (activity.state != null) ...[
            const SizedBox(height: 2),
            Text(
              activity.state!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
