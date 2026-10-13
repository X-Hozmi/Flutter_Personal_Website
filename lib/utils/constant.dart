const String gitHubApiUrl = 'https://api.github.com';

/// Public identifiers used by the website.
///
/// None of these are secrets: they are visible to anyone visiting the site.
/// They can be overridden at build time, e.g.
/// `flutter build web --dart-define=GITHUB_USERNAME=someone`.
const String gitHubUsername = String.fromEnvironment(
  'GITHUB_USERNAME',
  defaultValue: 'X-Hozmi',
);

/// Medium username (including the leading `@`) used for the blog feed.
const String mediumUser = String.fromEnvironment(
  'MEDIUM_USER',
  defaultValue: '@haidar17042001',
);

/// Discord user ID for Lanyard presence.
const String discordPresenceUserId = String.fromEnvironment(
  'DISCORD_PRESENCE_USER_ID',
  defaultValue: '331943910937067530',
);

/// Headers for anonymous GitHub API requests.
///
/// The browser never sends credentials: any token shipped in a web bundle is
/// readable by every visitor. Rate-limit fallbacks are served from the
/// build-time snapshot instead (see `tool/generate_github_snapshot.dart`).
const Map<String, String> gitHubApiHeaders = {
  'Accept': 'application/vnd.github+json',
};

class Routes {
  static const String homePage = '/';
  static const String projectPage = '/projects';
  static const String blogPage = '/blogs';
}
