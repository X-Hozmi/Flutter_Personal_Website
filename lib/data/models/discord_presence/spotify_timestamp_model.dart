import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/spotify_timestamp.dart';

class SpotifyTimestampsModel extends Equatable {
  final int start;
  final int end;

  const SpotifyTimestampsModel({required this.start, required this.end});

  factory SpotifyTimestampsModel.fromJson(Map<String, dynamic> json) {
    return SpotifyTimestampsModel(
      start: json['start'] ?? 0,
      end: json['end'] ?? 0,
    );
  }

  SpotifyTimestamps toEntity() {
    return SpotifyTimestamps(start: start, end: end);
  }

  @override
  List<Object?> get props => [start, end];
}
