import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/github_repo.dart';
import 'package:flutter_personal_website/domain/repositories/project_repository.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class GetGitHubRepos {
  final ProjectRepository repository;

  GetGitHubRepos(this.repository);

  Future<Either<Failure, List<GitHubRepo>>> execute() {
    return repository.getGitHubRepos();
  }
}
