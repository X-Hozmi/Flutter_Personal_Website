part of '../home_page.dart';

Widget buildDiscordPresenceContent(
  BuildContext context,
  DiscordPresenceController discordController,
) {
  switch (discordController.state) {
    case RequestState.loading:
      return const Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF5865F2),
            ),
          ),
          SizedBox(width: 12),
          Text('Loading Discord presence...'),
        ],
      );

    case RequestState.error:
      return Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Failed to load Discord presence',
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () => discordController.refreshDiscordPresence(),
            child: const Text('Retry'),
          ),
        ],
      );

    case RequestState.loaded:
      final user = discordController.user;
      final presence = discordController.discordPresence;

      if (user == null || presence == null) {
        return const Text('No Discord data available');
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Discord Avatar or Default Icon
              user.avatar != null
                  ? CircleAvatar(
                    radius: 15,
                    backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
                    backgroundColor: const Color(0xFF5865F2),
                  )
                  : const CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xFF5865F2),
                    child: Icon(Icons.discord, size: 16, color: Colors.white),
                  ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${user.effectiveName}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      getPresenceStatusText(discordController),
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Status indicator
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: getStatusColor(discordController),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),

          // Show Spotify if listening
          if (discordController.isListeningToSpotify &&
              discordController.currentSpotify != null)
            buildSpotifySection(context, discordController),

          // Show activities if any (excluding Spotify)
          if (discordController.activities.isNotEmpty &&
              !discordController.isOffline)
            buildActivitiesSection(context, discordController),
        ],
      );

    default:
      return const Text('Discord presence unavailable');
  }
}
