import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_personal_website/data/models/github_repo_model.dart';
import 'package:flutter_personal_website/data/models/profile/github_profile_model.dart';
import 'package:flutter_personal_website/utils/exception.dart';

/// Reads the GitHub snapshot bundled at build time.
///
/// The snapshot is produced by `tool/generate_github_snapshot.dart` and serves
/// as a fallback when the anonymous GitHub API is rate limited or unreachable.
abstract class GitHubSnapshotDataSource {
  Future<GitHubProfileModel> getProfile();

  Future<List<GitHubRepoModel>> getRepos();
}

class GitHubSnapshotDataSourceImpl implements GitHubSnapshotDataSource {
  GitHubSnapshotDataSourceImpl({Future<String> Function()? loader})
    : _loader = loader ?? (() => rootBundle.loadString(assetPath));

  static const String assetPath = 'assets/data/github_snapshot.json';

  final Future<String> Function() _loader;
  Map<String, dynamic>? _cache;

  Future<Map<String, dynamic>> _snapshot() async {
    if (_cache != null) return _cache!;
    try {
      final decoded = json.decode(await _loader()) as Map<String, dynamic>;
      return _cache = decoded;
    } catch (error) {
      throw CacheException('GitHub snapshot unavailable: $error');
    }
  }

  @override
  Future<GitHubProfileModel> getProfile() async {
    final profile = (await _snapshot())['profile'];
    if (profile is! Map<String, dynamic>) {
      throw CacheException('GitHub snapshot has no profile');
    }
    return GitHubProfileModel.fromJson(profile);
  }

  @override
  Future<List<GitHubRepoModel>> getRepos() async {
    final repos = (await _snapshot())['repos'];
    if (repos is! List<dynamic>) {
      throw CacheException('GitHub snapshot has no repositories');
    }
    return GitHubRepoModel.fromJsonList(repos);
  }
}
