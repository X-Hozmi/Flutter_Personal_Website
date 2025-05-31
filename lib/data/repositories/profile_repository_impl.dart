import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_personal_website/domain/entities/profile/github_profile.dart';
import 'package:flutter_personal_website/domain/repositories/profile_repository.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, GitHubProfile>> getGitHubProfile() async {
    try {
      final result = await remoteDataSource.getGitHubProfile();
      return Right(result.toEntity());
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
