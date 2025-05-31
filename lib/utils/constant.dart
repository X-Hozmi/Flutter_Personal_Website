import 'dart:convert';

const String gitHubApiUrl = 'https://api.github.com';

const String mediumUser =
    '@MediumUsername'; // Replace with your Medium username. Please refer to https://medium.com for how to get your Medium username.

const String gitHubUsername =
    'GitHubUsername'; // Replace with your GitHub username. Please refer to https://github.com for how to get your GitHub username.

const String discordPresenceUserId =
    '1234567'; // Replace with your Discord user ID. Please refer to https://github.com/Phineas/lanyard for how to get your Discord user ID.

final String greeting = 'Hello there, I\'m a software developer!';

final String developerRoles = 'Flutter Developer / Mobile Developer';

final String gitHubAccessToken = base64Encode(
  utf8.encode(
    'GitHubUsername:github_access_token',
  ), // Replace with your GitHub username and personal access token --> user:access_token. Please refer to https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token for how to create a personal access token.
);

final gitHubAPIHeaders = {
  'Authorization': 'Basic $gitHubAccessToken',
  'Accept': 'application/vnd.github.v3+json',
  'User-Agent': 'Flutter-App',
};

final Map<String, List<String>> languageCache = {};

class Routes {
  static const String homePage = '/';
  static const String projectPage = '/projects';
  static const String blogPage = '/blogs';
}
