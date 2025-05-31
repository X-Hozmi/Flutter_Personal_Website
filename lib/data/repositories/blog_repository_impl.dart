import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_personal_website/domain/entities/blog/blog.dart';
import 'package:flutter_personal_website/domain/repositories/blog_repository.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;

  BlogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {
    try {
      final blogModels = await remoteDataSource.getBlogs();
      final blogs = blogModels.map((model) => model.toEntity()).toList();
      return Right(blogs);
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
