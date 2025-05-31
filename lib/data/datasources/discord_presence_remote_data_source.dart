import 'dart:async';
import 'dart:convert';

import 'package:flutter_personal_website/data/models/discord_presence/discord_presence_model.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class DiscordPresenceRemoteDataSource {
  Future<DiscordPresenceModel> getDiscordPresence();
}

class DiscordPresenceRemoteDataSourceImpl
    implements DiscordPresenceRemoteDataSource {
  final http.Client client;
  final Duration timeoutDuration;
  final String userId;

  DiscordPresenceRemoteDataSourceImpl({
    required this.client,
    this.timeoutDuration = const Duration(seconds: 10),
    this.userId = discordPresenceUserId,
  });

  @override
  Future<DiscordPresenceModel> getDiscordPresence() async {
    try {
      final response = await client
          .get(
            Uri.parse('https://api.lanyard.rest/v1/users/$userId'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return DiscordPresenceModel.fromJson(jsonData);
      } else {
        throw ServerException();
      }
    } on TimeoutException {
      throw TimeoutException('Request to get Discord presence timed out');
    } on FormatException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
