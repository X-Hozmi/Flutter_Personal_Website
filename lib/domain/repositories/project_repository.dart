import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/github_repo.dart';
import 'package:flutter_personal_website/utils/failure.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<GitHubRepo>>> getGitHubRepos();
}
