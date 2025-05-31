part of '../home_page.dart';

Widget buildSpotifySection(
  BuildContext context,
  DiscordPresenceController discordController,
) {
  final spotify = discordController.currentSpotify!;

  return Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(12),
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
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.music_note),
                ),
            errorWidget:
                (context, url, error) => Container(
                  width: 40,
                  height: 40,
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
                style: TextStyle(
                  color: const Color(0xFF1DB954),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                spotify.song,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
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
                  fontSize: 12,
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
