import 'package:equatable/equatable.dart';

/// A public GitHub repository, mapped from the GitHub REST API.
class GitHubRepo extends Equatable {
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

  const GitHubRepo({
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
