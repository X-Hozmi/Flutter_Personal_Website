import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/github_repo.dart';

class GitHubRepoModel extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final String htmlUrl;
  final String languagesUrl;
  final String? homepage;
  final int stargazersCount;
  final int forksCount;
  final String language;
  final bool isFork;
  final bool isArchived;

  const GitHubRepoModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.htmlUrl,
    required this.languagesUrl,
    this.homepage,
    required this.stargazersCount,
    required this.forksCount,
    required this.language,
    required this.isFork,
    required this.isArchived,
  });

  factory GitHubRepoModel.fromJson(Map<String, dynamic> json) {
    return GitHubRepoModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      htmlUrl: json['html_url'] as String? ?? '',
      languagesUrl: json['languages_url'] as String? ?? '',
      homepage: json['homepage'] as String?,
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      forksCount: json['forks_count'] as int? ?? 0,
      language: json['language'] as String? ?? '',
      isFork: json['fork'] as bool? ?? false,
      isArchived: json['archived'] as bool? ?? false,
    );
  }

  static List<GitHubRepoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => GitHubRepoModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  GitHubRepo toEntity() {
    return GitHubRepo(
      id: id,
      name: name,
      fullName: fullName,
      description: description,
      htmlUrl: htmlUrl,
      languagesUrl: languagesUrl,
      homepage: homepage,
      stargazersCount: stargazersCount,
      forksCount: forksCount,
      language: language,
      isFork: isFork,
      isArchived: isArchived,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    fullName,
    description,
    htmlUrl,
    languagesUrl,
    homepage,
    stargazersCount,
    forksCount,
    language,
    isFork,
    isArchived,
  ];
}
