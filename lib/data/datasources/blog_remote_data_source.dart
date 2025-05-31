import 'dart:async';
import 'dart:convert';

import 'package:flutter_personal_website/data/models/blog/blog_model.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class BlogRemoteDataSource {
  Future<List<BlogModel>> getBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final http.Client client;
  final Duration timeoutDuration;

  BlogRemoteDataSourceImpl({
    required this.client,
    this.timeoutDuration = const Duration(seconds: 10),
  });

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final response = await client
          .get(
            Uri.parse(
              'https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/$mediumUser',
            ),
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> apiResponse = json.decode(response.body);

        if (apiResponse['status'] != 'ok') {
          throw ServerException();
        }

        return BlogModel.fromApiResponse(apiResponse);
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
