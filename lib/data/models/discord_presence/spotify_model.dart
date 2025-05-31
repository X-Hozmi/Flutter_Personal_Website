import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/data/models/discord_presence/spotify_timestamp_model.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/spotify.dart';

class SpotifyModel extends Equatable {
  final String trackId;
  final SpotifyTimestampsModel timestamps;
  final String song;
  final String artist;
  final String albumArtUrl;
  final String album;

  const SpotifyModel({
    required this.trackId,
    required this.timestamps,
    required this.song,
    required this.artist,
    required this.albumArtUrl,
    required this.album,
  });

  factory SpotifyModel.fromJson(Map<String, dynamic> json) {
    return SpotifyModel(
      trackId: json['track_id'] ?? '',
      timestamps: SpotifyTimestampsModel.fromJson(json['timestamps']),
      song: json['song'] ?? '',
      artist: json['artist'] ?? '',
      albumArtUrl: json['album_art_url'] ?? '',
      album: json['album'] ?? '',
    );
  }

  Spotify toEntity() {
    return Spotify(
      trackId: trackId,
      timestamps: timestamps.toEntity(),
      song: song,
      artist: artist,
      albumArtUrl: albumArtUrl,
      album: album,
    );
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
