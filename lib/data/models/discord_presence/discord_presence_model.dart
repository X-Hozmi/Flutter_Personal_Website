import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/data/models/discord_presence/activity_model.dart';
import 'package:flutter_personal_website/data/models/discord_presence/discord_user_model.dart';
import 'package:flutter_personal_website/data/models/discord_presence/spotify_model.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_presence.dart';

class DiscordPresenceModel extends Equatable {
  final bool success;
  final DiscordUserModel discordUser;
  final String discordStatus;
  final bool activeOnDiscordWeb;
  final bool activeOnDiscordDesktop;
  final bool activeOnDiscordMobile;
  final bool activeOnDiscordEmbedded;
  final bool listeningToSpotify;
  final SpotifyModel? spotify;
  final List<ActivityModel> activities;

  const DiscordPresenceModel({
    required this.success,
    required this.discordUser,
    required this.discordStatus,
    required this.activeOnDiscordWeb,
    required this.activeOnDiscordDesktop,
    required this.activeOnDiscordMobile,
    required this.activeOnDiscordEmbedded,
    required this.listeningToSpotify,
    this.spotify,
    required this.activities,
  });

  factory DiscordPresenceModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return DiscordPresenceModel(
      success: json['success'] ?? false,
      discordUser: DiscordUserModel.fromJson(data['discord_user']),
      discordStatus: data['discord_status'] ?? 'offline',
      activeOnDiscordWeb: data['active_on_discord_web'] ?? false,
      activeOnDiscordDesktop: data['active_on_discord_desktop'] ?? false,
      activeOnDiscordMobile: data['active_on_discord_mobile'] ?? false,
      activeOnDiscordEmbedded: data['active_on_discord_embedded'] ?? false,
      listeningToSpotify: data['listening_to_spotify'] ?? false,
      spotify:
          data['spotify'] != null
              ? SpotifyModel.fromJson(data['spotify'])
              : null,
      activities:
          (data['activities'] as List<dynamic>?)
              ?.map((activity) => ActivityModel.fromJson(activity))
              .toList() ??
          [],
    );
  }

  DiscordPresence toEntity() {
    return DiscordPresence(
      success: success,
      discordUser: discordUser.toEntity(),
      discordStatus: discordStatus,
      activeOnDiscordWeb: activeOnDiscordWeb,
      activeOnDiscordDesktop: activeOnDiscordDesktop,
      activeOnDiscordMobile: activeOnDiscordMobile,
      activeOnDiscordEmbedded: activeOnDiscordEmbedded,
      listeningToSpotify: listeningToSpotify,
      spotify: spotify?.toEntity(),
      activities: activities.map((activity) => activity.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
    success,
    discordUser,
    discordStatus,
    activeOnDiscordWeb,
    activeOnDiscordDesktop,
    activeOnDiscordMobile,
    activeOnDiscordEmbedded,
    listeningToSpotify,
    spotify,
    activities,
  ];
}
