import 'dart:async';
import 'dart:convert';

import 'package:flutter_personal_website/data/models/profile/github_profile_model.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemoteDataSource {
  Future<GitHubProfileModel> getGitHubProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;
  final Duration timeoutDuration;

  ProfileRemoteDataSourceImpl({
    required this.client,
    this.timeoutDuration = const Duration(seconds: 10),
  });

  @override
  Future<GitHubProfileModel> getGitHubProfile() async {
    try {
      final response = await client
          .get(
            Uri.parse('$gitHubApiUrl/users/$gitHubUsername'),
            headers: gitHubAPIHeaders,
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        return GitHubProfileModel.fromJson(jsonMap);
      } else {
        throw ServerException();
      }
    } on TimeoutException {
      throw TimeoutException('Request to get blogs timed out');
    } on FormatException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
