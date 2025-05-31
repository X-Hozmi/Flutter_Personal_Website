import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/blog/blog.dart';
import 'package:flutter_personal_website/domain/repositories/blog_repository.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class GetBlogs {
  final BlogRepository repository;

  GetBlogs(this.repository);

  Future<Either<Failure, List<Blog>>> execute() {
    return repository.getBlogs();
  }
}
