import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/data/datasources/project_remote_data_source.dart';
import 'package:flutter_personal_website/domain/entities/project/project.dart';
import 'package:flutter_personal_website/domain/repositories/project_repository.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      final projectModels = await remoteDataSource.getProjects();
      final projects = projectModels.map((model) => model.toEntity()).toList();
      return Right(projects);
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
