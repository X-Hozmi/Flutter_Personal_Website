import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/profile/github_profile.dart';
import 'package:flutter_personal_website/domain/repositories/profile_repository.dart';
import 'package:flutter_personal_website/utils/failure.dart';

class GetGitHubProfile {
  final ProfileRepository repository;

  GetGitHubProfile(this.repository);

  Future<Either<Failure, GitHubProfile>> execute() {
    return repository.getGitHubProfile();
  }
}
