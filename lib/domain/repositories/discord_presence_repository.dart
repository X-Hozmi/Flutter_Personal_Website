import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_presence.dart';
import 'package:flutter_personal_website/utils/failure.dart';

abstract class DiscordPresenceRepository {
  Future<Either<Failure, DiscordPresence>> getDiscordPresence();
}
