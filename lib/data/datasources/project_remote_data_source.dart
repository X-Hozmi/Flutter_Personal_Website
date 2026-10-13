import 'dart:async';
import 'dart:convert';

import 'package:flutter_personal_website/data/models/github_repo_model.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class ProjectRemoteDataSource {
  Future<List<GitHubRepoModel>> getGitHubRepos();
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final http.Client client;
  final Duration timeoutDuration;
  final String username;

  ProjectRemoteDataSourceImpl({
    required this.client,
    this.timeoutDuration = const Duration(seconds: 10),
    this.username = gitHubUsername,
  });

  @override
  Future<List<GitHubRepoModel>> getGitHubRepos() async {
    try {
      final response = await client
          .get(
            Uri.parse(
              '$gitHubApiUrl/users/$username/repos?sort=updated&per_page=100',
            ),
            headers: gitHubApiHeaders,
          )
          .timeout(timeoutDuration);

      if (response.statusCode != 200) {
        throw ServerException('GitHub responded ${response.statusCode}');
      }
      final jsonList = json.decode(response.body) as List<dynamic>;
      return GitHubRepoModel.fromJsonList(jsonList);
    } on TimeoutException {
      throw TimeoutException('Request to get repositories timed out');
    } on ServerException {
      rethrow;
    } catch (error) {
      throw ServerException('Invalid GitHub repositories response: $error');
    }
  }
}
