import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/project/project.dart';
import 'package:flutter_personal_website/utils/failure.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<Project>>> getProjects();
}
