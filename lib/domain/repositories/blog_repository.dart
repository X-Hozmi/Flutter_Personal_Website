import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/blog/blog.dart';
import 'package:flutter_personal_website/utils/failure.dart';

abstract class BlogRepository {
  Future<Either<Failure, List<Blog>>> getBlogs();
}
