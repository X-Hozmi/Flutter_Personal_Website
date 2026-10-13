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
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      avatar: json['avatar'] as String?,
      discriminator: json['discriminator'] as String? ?? '0',
      bot: json['bot'] as bool? ?? false,
      globalName: json['global_name'] as String?,
      displayName: json['display_name'] as String?,
      publicFlags: json['public_flags'] as int? ?? 0,
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
