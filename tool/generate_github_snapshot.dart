// Generates `assets/data/github_snapshot.json` from the GitHub REST API.
//
// The website calls the public GitHub API directly from the browser without
// any credentials. Anonymous requests are limited to 60 per hour per visitor
// IP, so this snapshot is bundled as a fallback the app uses whenever the live
// request fails (rate limit, outage, offline).
//
// The token is optional and only used on the machine that runs this script.
// It is never written into the snapshot or the web build. Resolution order:
//   1. `GITHUB_TOKEN` environment variable
//   2. `GITHUB_ACCESS_TOKEN=` line in the local, git-ignored `.env` file
//
// Usage (run before `flutter build web`):
//   dart run tool/generate_github_snapshot.dart [username]
import 'dart:convert';
import 'dart:io';

const _defaultUsername = 'X-Hozmi';
const _outputPath = 'assets/data/github_snapshot.json';

const _profileFields = ['id', 'login', 'name', 'avatar_url', 'html_url', 'bio'];

const _repoFields = [
  'id',
  'name',
  'full_name',
  'description',
  'html_url',
  'homepage',
  'stargazers_count',
  'forks_count',
  'language',
  'fork',
  'archived',
  'pushed_at',
];

Future<void> main(List<String> args) async {
  final username = args.isNotEmpty ? args.first : _defaultUsername;
  final client = HttpClient();
  var token = _resolveToken();

  try {
    if (token != null && !await _isTokenAccepted(client, token)) {
      stderr.writeln(
        'Warning: GitHub rejected the configured token (expired or revoked). '
        'Falling back to anonymous requests.',
      );
      token = null;
    }

    final profile = await _getJson(client, '/users/$username', token);
    final repos = await _getJson(
      client,
      '/users/$username/repos?sort=updated&per_page=100',
      token,
    );

    final snapshot = {
      'generated_at': DateTime.now().toUtc().toIso8601String(),
      'profile': _pick(profile as Map<String, dynamic>, _profileFields),
      'repos': [
        for (final repo in repos as List<dynamic>)
          _pick(repo as Map<String, dynamic>, _repoFields),
      ],
    };

    final file = File(_outputPath)..createSync(recursive: true);
    file.writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(snapshot)}\n',
    );
    stdout.writeln(
      'Wrote $_outputPath (${(snapshot['repos'] as List).length} repos, '
      'authenticated: ${token != null}).',
    );
  } on Exception catch (error) {
    stderr.writeln('Snapshot generation failed: $error');
    exitCode = 1;
  } finally {
    client.close();
  }
}

Map<String, dynamic> _pick(Map<String, dynamic> source, List<String> keys) => {
  for (final key in keys) key: source[key],
};

Future<Object?> _getJson(HttpClient client, String path, String? token) async {
  final request = await client.getUrl(Uri.parse('https://api.github.com$path'));
  request.headers
    ..set(HttpHeaders.acceptHeader, 'application/vnd.github+json')
    ..set(HttpHeaders.userAgentHeader, 'x-hozmi-snapshot-generator');
  if (token != null) {
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
  }

  final response = await request.close();
  final body = await response.transform(utf8.decoder).join();
  if (response.statusCode != HttpStatus.ok) {
    throw HttpException('GET $path returned ${response.statusCode}: $body');
  }
  return jsonDecode(body);
}

Future<bool> _isTokenAccepted(HttpClient client, String token) async {
  try {
    await _getJson(client, '/rate_limit', token);
    return true;
  } on HttpException {
    return false;
  }
}

String? _resolveToken() {
  final fromEnvironment = Platform.environment['GITHUB_TOKEN'];
  if (fromEnvironment != null && fromEnvironment.isNotEmpty) {
    return fromEnvironment;
  }

  final envFile = File('.env');
  if (!envFile.existsSync()) return null;

  for (final line in envFile.readAsLinesSync()) {
    final trimmed = line.trim();
    if (trimmed.startsWith('GITHUB_ACCESS_TOKEN=')) {
      final value = trimmed.substring('GITHUB_ACCESS_TOKEN='.length).trim();
      return value.isEmpty ? null : value;
    }
  }
  return null;
}
