part of '../home_page.dart';

Widget buildSpotifySection(
  BuildContext context,
  DiscordPresenceController discordController,
) {
  final spotify = discordController.currentSpotify!;
  final isMobile = ResponsiveBreakpoints.of(context).isMobile;

  return Container(
    margin: EdgeInsets.only(top: isMobile ? 8 : 12),
    padding: EdgeInsets.all(isMobile ? 8 : 12),
    decoration: BoxDecoration(
      color: const Color(0xFF1DB954).withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFF1DB954).withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        // Album art
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: spotify.albumArtUrl,
            width: isMobile ? 32 : 40,
            height: isMobile ? 32 : 40,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Container(
                  width: isMobile ? 32 : 40,
                  height: isMobile ? 32 : 40,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.music_note, size: isMobile ? 16 : 20),
                ),
            errorWidget:
                (context, url, error) => Container(
                  width: isMobile ? 32 : 40,
                  height: isMobile ? 32 : 40,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.music_note, size: isMobile ? 16 : 20),
                ),
          ),
        ),
        SizedBox(width: isMobile ? 8 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Listening to Spotify',
                style: TextStyle(
                  color: const Color(0xFF1DB954),
                  fontSize: isMobile ? 10 : 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                spotify.song,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: isMobile ? 12 : 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'by ${spotify.artist}',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                  fontSize: isMobile ? 11 : 12,
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
