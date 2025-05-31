import 'package:equatable/equatable.dart';

class GitHubProfile extends Equatable {
  final int id;
  final String login;
  final String name;
  final String avatarUrl;
  final String htmlUrl;
  final String bio;

  const GitHubProfile({
    required this.id,
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.bio,
  });

  @override
  List<Object?> get props => [id, login, name, avatarUrl, htmlUrl, bio];
}
