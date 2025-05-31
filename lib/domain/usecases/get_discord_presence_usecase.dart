import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_presence.dart';
import 'package:flutter_personal_website/domain/repositories/discord_presence_repository.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class GetDiscordPresence {
  final DiscordPresenceRepository repository;

  GetDiscordPresence(this.repository);

  Future<Either<Failure, DiscordPresence>> execute() {
    return repository.getDiscordPresence();
  }
}
