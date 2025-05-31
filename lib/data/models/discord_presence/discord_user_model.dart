import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_user.dart';

class DiscordUserModel extends Equatable {
  final String id;
  final String username;
  final String? avatar;
  final String discriminator;
  final bool bot;
  final String? globalName;
  final String? displayName;
  final int publicFlags;

  const DiscordUserModel({
    required this.id,
    required this.username,
    this.avatar,
    required this.discriminator,
    required this.bot,
    this.globalName,
    this.displayName,
    required this.publicFlags,
  });

  factory DiscordUserModel.fromJson(Map<String, dynamic> json) {
    return DiscordUserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'],
      discriminator: json['discriminator'] ?? '0',
      bot: json['bot'] ?? false,
      globalName: json['global_name'],
      displayName: json['display_name'],
      publicFlags: json['public_flags'] ?? 0,
    );
  }

  DiscordUser toEntity() {
    return DiscordUser(
      id: id,
      username: username,
      avatar: avatar,
      discriminator: discriminator,
      bot: bot,
      globalName: globalName,
      displayName: displayName,
      publicFlags: publicFlags,
    );
  }

  @override
  List<Object?> get props => [
    id,
    username,
    avatar,
    discriminator,
    bot,
    globalName,
    displayName,
    publicFlags,
  ];
}
