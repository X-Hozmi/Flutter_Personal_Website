import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/profile/github_profile.dart';

class GitHubProfileModel extends Equatable {
  final int id;
  final String login;
  final String name;
  final String avatarUrl;
  final String htmlUrl;
  final String bio;

  const GitHubProfileModel({
    required this.id,
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.bio,
  });

  factory GitHubProfileModel.fromJson(Map<String, dynamic> json) {
    return GitHubProfileModel(
      id: json['id'] as int? ?? 0,
      login: json['login'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      htmlUrl: json['html_url'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'name': name,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'bio': bio,
    };
  }

  GitHubProfile toEntity() {
    return GitHubProfile(
      id: id,
      login: login,
      name: name,
      avatarUrl: avatarUrl,
      htmlUrl: htmlUrl,
      bio: bio,
    );
  }

  @override
  List<Object?> get props => [id, login, name, avatarUrl, htmlUrl, bio];
}
