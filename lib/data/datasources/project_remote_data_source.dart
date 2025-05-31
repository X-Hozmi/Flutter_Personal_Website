import 'dart:async';
import 'dart:convert';

import 'package:flutter_personal_website/data/models/project/project_model.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class ProjectRemoteDataSource {
  Future<List<ProjectModel>> getProjects();
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final http.Client client;
  final Duration timeoutDuration;

  ProjectRemoteDataSourceImpl({
    required this.client,
    this.timeoutDuration = const Duration(seconds: 10),
  });

  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      final response = await client
          .get(
            Uri.parse('$gitHubApiUrl/users/$gitHubUsername/repos'),
            headers: gitHubAPIHeaders,
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return ProjectModel.fromJsonList(jsonList);
      } else {
        throw ServerException();
      }
    } on TimeoutException {
      throw TimeoutException('Request to get projects timed out');
    } on FormatException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
