import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/activity.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_user.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/spotify.dart';

class DiscordPresence extends Equatable {
  final bool success;
  final DiscordUser discordUser;
  final String discordStatus;
  final bool activeOnDiscordWeb;
  final bool activeOnDiscordDesktop;
  final bool activeOnDiscordMobile;
  final bool activeOnDiscordEmbedded;
  final bool listeningToSpotify;
  final Spotify? spotify;
  final List<Activity> activities;

  const DiscordPresence({
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
