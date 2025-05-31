import 'package:dartz/dartz.dart';
import 'package:flutter_personal_website/domain/entities/profile/github_profile.dart';
import 'package:flutter_personal_website/utils/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, GitHubProfile>> getGitHubProfile();
}
