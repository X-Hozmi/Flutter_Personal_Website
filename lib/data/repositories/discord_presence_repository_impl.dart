import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/data/datasources/discord_presence_remote_data_source.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_presence.dart';
import 'package:flutter_personal_website/domain/repositories/discord_presence_repository.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class DiscordPresenceRepositoryImpl implements DiscordPresenceRepository {
  final DiscordPresenceRemoteDataSource remoteDataSource;

  DiscordPresenceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DiscordPresence>> getDiscordPresence() async {
    try {
      final discordPresenceModel = await remoteDataSource.getDiscordPresence();
      final discordPresence = discordPresenceModel.toEntity();
      return Right(discordPresence);
    } on ServerException {
      return Left(
        ServerFailure('Something\'s wrong from server. Please try again later'),
      );
    } on TimeoutException {
      return Left(
        TimeoutFailure(
          'Connection timed out. Maybe check your internet connection?',
        ),
      );
    } catch (e) {
      return Left(UnexpectedFailure('An unexpected error occurred: $e'));
    }
  }
}
