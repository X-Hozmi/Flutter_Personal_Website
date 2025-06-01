part of '../home_page.dart';

Widget buildDiscordPresenceContent(
  BuildContext context,
  DiscordPresenceController discordController,
) {
  final isMobile = ResponsiveBreakpoints.of(context).isMobile;

  switch (discordController.state) {
    case RequestState.loading:
      return Row(
        children: [
          SizedBox(
            width: isMobile ? 16 : 20,
            height: isMobile ? 16 : 20,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF5865F2),
            ),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Text(
            'Loading Discord presence...',
            style: TextStyle(fontSize: isMobile ? 13 : 14),
          ),
        ],
      );

    case RequestState.error:
      return Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: isMobile ? 16 : 20,
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Expanded(
            child: Text(
              'Failed to load Discord presence',
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: isMobile ? 13 : 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () => discordController.refreshDiscordPresence(),
            child: Text(
              'Retry',
              style: TextStyle(fontSize: isMobile ? 12 : 14),
            ),
          ),
        ],
      );

    case RequestState.loaded:
      final user = discordController.user;
      final presence = discordController.discordPresence;

      if (user == null || presence == null) {
        return Text(
          'No Discord data available',
          style: TextStyle(fontSize: isMobile ? 13 : 14),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Discord Avatar or Default Icon
              user.avatar != null
                  ? CircleAvatar(
                    radius: isMobile ? 12 : 15,
                    backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
                    backgroundColor: const Color(0xFF5865F2),
                  )
                  : CircleAvatar(
                    radius: isMobile ? 12 : 15,
                    backgroundColor: const Color(0xFF5865F2),
                    child: Icon(
                      Icons.discord,
                      size: isMobile ? 14 : 16,
                      color: Colors.white,
                    ),
                  ),
              SizedBox(width: isMobile ? 8 : 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${user.effectiveName}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: isMobile ? 13 : 14,
                      ),
                    ),
                    Text(
                      getPresenceStatusText(discordController),
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: isMobile ? 11 : 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Status indicator
              Container(
                width: isMobile ? 10 : 12,
                height: isMobile ? 10 : 12,
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
      return Text(
        'Discord presence unavailable',
        style: TextStyle(fontSize: isMobile ? 13 : 14),
      );
  }
}
