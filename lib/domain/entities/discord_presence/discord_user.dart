import 'package:equatable/equatable.dart';

class DiscordUser extends Equatable {
  final String id;
  final String username;
  final String? avatar;
  final String discriminator;
  final bool bot;
  final String? globalName;
  final String? displayName;
  final int publicFlags;

  const DiscordUser({
    required this.id,
    required this.username,
    this.avatar,
    required this.discriminator,
    required this.bot,
    this.globalName,
    this.displayName,
    required this.publicFlags,
  });

  String get avatarUrl {
    if (avatar == null) return '';
    return 'https://cdn.discordapp.com/avatars/$id/$avatar.png';
  }

  String get effectiveName {
    return displayName ?? globalName ?? username;
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
