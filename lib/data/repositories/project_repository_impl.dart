import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/data/datasources/github_snapshot_data_source.dart';
import 'package:flutter_personal_website/data/datasources/project_remote_data_source.dart';
import 'package:flutter_personal_website/domain/entities/github_repo.dart';
import 'package:flutter_personal_website/domain/repositories/project_repository.dart';
import 'package:flutter_personal_website/utils/failure.dart';

/// Serves live repositories, falling back to the bundled build-time snapshot
/// when the anonymous GitHub API is rate limited or unreachable.
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final GitHubSnapshotDataSource snapshotDataSource;

  ProjectRepositoryImpl({
    required this.remoteDataSource,
    required this.snapshotDataSource,
  });

  @override
  Future<Either<Failure, List<GitHubRepo>>> getGitHubRepos() async {
    try {
      final repos = await remoteDataSource.getGitHubRepos();
      return Right(repos.map((repo) => repo.toEntity()).toList());
    } catch (error) {
      developer.log(
        'Live GitHub repositories unavailable, using snapshot',
        name: 'project.repository',
        error: error,
      );
    }

    try {
      final repos = await snapshotDataSource.getRepos();
      return Right(repos.map((repo) => repo.toEntity()).toList());
    } catch (error) {
      return const Left(
        ServerFailure(
          'Could not load repositories from GitHub. Please try again later.',
        ),
      );
    }
  }
}
