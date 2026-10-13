import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/data/datasources/github_snapshot_data_source.dart';
import 'package:flutter_personal_website/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_personal_website/domain/entities/profile/github_profile.dart';
import 'package:flutter_personal_website/domain/repositories/profile_repository.dart';
import 'package:flutter_personal_website/utils/failure.dart';

/// Serves the live GitHub profile, falling back to the bundled build-time
/// snapshot when the anonymous GitHub API is rate limited or unreachable.
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final GitHubSnapshotDataSource snapshotDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.snapshotDataSource,
  });

  @override
  Future<Either<Failure, GitHubProfile>> getGitHubProfile() async {
    try {
      final result = await remoteDataSource.getGitHubProfile();
      return Right(result.toEntity());
    } catch (error) {
      developer.log(
        'Live GitHub profile unavailable, using snapshot',
        name: 'profile.repository',
        error: error,
      );
    }

    try {
      final result = await snapshotDataSource.getProfile();
      return Right(result.toEntity());
    } catch (error) {
      return const Left(
        ServerFailure('Could not load the GitHub profile right now.'),
      );
    }
  }
}
