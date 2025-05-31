import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/project/project.dart';
import 'package:flutter_personal_website/domain/repositories/project_repository.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class GetProjects {
  final ProjectRepository repository;

  GetProjects(this.repository);

  Future<Either<Failure, List<Project>>> execute() {
    return repository.getProjects();
  }
}
