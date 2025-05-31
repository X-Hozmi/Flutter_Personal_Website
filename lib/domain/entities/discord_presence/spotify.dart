import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/spotify_timestamp.dart';

class Spotify extends Equatable {
  final String trackId;
  final SpotifyTimestamps timestamps;
  final String song;
  final String artist;
  final String albumArtUrl;
  final String album;

  const Spotify({
    required this.trackId,
    required this.timestamps,
    required this.song,
    required this.artist,
    required this.albumArtUrl,
    required this.album,
  });

  String get spotifyUrl {
    return 'https://open.spotify.com/track/$trackId';
  }

  Duration get duration {
    return Duration(milliseconds: timestamps.end - timestamps.start);
  }

  Duration get elapsed {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - timestamps.start;
    return Duration(milliseconds: elapsed.clamp(0, duration.inMilliseconds));
  }

  double get progress {
    if (duration.inMilliseconds == 0) return 0.0;
    return elapsed.inMilliseconds / duration.inMilliseconds;
  }

  @override
  List<Object?> get props => [
    trackId,
    timestamps,
    song,
    artist,
    albumArtUrl,
    album,
  ];
}
