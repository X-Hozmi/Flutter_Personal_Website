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
      success: json['success'] as bool? ?? false,
      discordUser: DiscordUserModel.fromJson(
        data['discord_user'] as Map<String, dynamic>,
      ),
      discordStatus: data['discord_status'] as String? ?? 'offline',
      activeOnDiscordWeb: data['active_on_discord_web'] as bool? ?? false,
      activeOnDiscordDesktop:
          data['active_on_discord_desktop'] as bool? ?? false,
      activeOnDiscordMobile: data['active_on_discord_mobile'] as bool? ?? false,
      activeOnDiscordEmbedded:
          data['active_on_discord_embedded'] as bool? ?? false,
      listeningToSpotify: data['listening_to_spotify'] as bool? ?? false,
      spotify:
          data['spotify'] != null
              ? SpotifyModel.fromJson(data['spotify'] as Map<String, dynamic>)
              : null,
      activities:
          (data['activities'] as List<dynamic>?)
              ?.map(
                (activity) => ActivityModel.fromJson(
                  activity as Map<String, dynamic>,
                ),
              )
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
