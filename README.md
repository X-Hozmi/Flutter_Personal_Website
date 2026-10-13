# flutter_personal_website

Personal website of **Abdillah Haidar Mahendro**, Backend Developer and
Infrastructure Engineer. Built with Flutter (web-first), clean architecture,
and GetX for state management. Live at https://x-hozmi.github.io/.

## Features

- **Home**: about, experience, research and publications, education, skills,
  certificates (grouped, with verification links), live Discord/Spotify
  presence via Lanyard, contact links, and a downloadable CV.
- **Projects**: featured projects from the CV plus public GitHub repositories.
- **Blog**: Medium RSS feed via rss2json.
- **Theming**: persisted light/dark toggle, `ColorScheme.fromSeed`.

CV content lives in `lib/utils/cv_data.dart`. The source documents are in
`reference/`; update both together.

## GitHub data and secrets

The browser calls the public GitHub API **without credentials**. A token in a
web bundle is readable by every visitor, so none is shipped.

Anonymous requests are limited to 60 per hour per visitor IP. When the live
request fails, the app falls back to `assets/data/github_snapshot.json`,
which is generated before each build:

```bash
dart run tool/generate_github_snapshot.dart
```

The script optionally reads `GITHUB_TOKEN` (environment) or
`GITHUB_ACCESS_TOKEN` from the local `.env` (see `.env.example`) to avoid the
rate limit on your machine. The token is never written to the snapshot or
the build. Use a fine-grained, read-only token. Never add `.env` to the
pubspec assets.

Public identifiers can be overridden at build time with `--dart-define`:
`GITHUB_USERNAME`, `MEDIUM_USER`, `DISCORD_PRESENCE_USER_ID`.

## Development

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

## Release

```bash
dart run tool/generate_github_snapshot.dart
flutter build web --release
```

Copy `build/web/` into the `X-Hozmi.github.io` repository. The CV PDF is
served from `web/resume/`. Replace it there when the CV changes.

## Architecture

```text
lib/
├── data/            Data sources (GitHub API + bundled snapshot, Medium,
│                    Lanyard), models, repository implementations
├── domain/          Entities, repository contracts, use cases
├── presentation/    GetX controllers, pages, shared widgets, theme
├── utils/           Constants, CV data, failures, URL launch
├── injection.dart   Manual DI with Get.lazyPut
└── app_router.dart  GoRouter + StatefulShellRoute
tool/                Build-time scripts
```
