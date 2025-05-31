# Personal Website - Flutter

A modern personal website built with Flutter that showcases your profile, projects, and blog posts. The application dynamically fetches data from GitHub and Discord APIs to keep your information up-to-date.

## Features

### 🏠 Home Page

- Personal greetings and introduction
- Real-time Discord presence status using [Lanyard API](https://github.com/Phineas/lanyard)
- "About me" section pulled from your GitHub bio
- Profile picture sourced from GitHub
- Current Spotify activity display (when available)

### 🚀 Projects Page

- Automatically fetches repositories from GitHub API
- Project cards displaying:
  - Project thumbnails (in development)
  - Repository title and description
  - Programming languages used
  - Direct links to repositories

### 📝 Blog Page

*(Currently in development)*

- Will integrate with Medium RSS feed
- Fetches blog posts using RSS2JSON API: `https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/$mediumUser`
- Converts RSS feed to JSON for easy consumption

## Architecture

This project follows **Clean Architecture** principles with three distinct layers:

- **Data Layer**: Handles API calls, data models, and repository implementations
- **Domain Layer**: Contains business logic, entities, and use cases
- **Presentation Layer**: Manages UI components, controllers, and state management

```text
lib/
├── data/
│   ├── datasources/     # API data sources
│   ├── models/          # Data models
│   └── repositories/    # Repository implementations
├── domain/
│   ├── entities/        # Business entities
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business use cases
└── presentation/
    ├── controllers/     # State management
    └── pages/           # UI components
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- A GitHub account
- A Discord account (optional, for presence feature)
- A Medium account (optional, for blog feature)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/X-Hozmi/Flutter_Personal_Website.git
   cd Flutter_Personal_Website
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure your information**

   Edit `lib/utils/constant.dart` with your personal information:

   ```dart
   // GitHub Configuration
   const String gitHubUsername = 'YourGitHubUsername';
   
   // Medium Configuration (optional)
   const String mediumUser = '@YourMediumUsername';
   
   // Discord Configuration (optional)
   const String discordPresenceUserId = 'YourDiscordUserID';
   
   // GitHub Personal Access Token
   final String gitHubAccessToken = base64Encode(
     utf8.encode('YourGitHubUsername:YourPersonalAccessToken'),
   );
   ```

### Required Configurations

#### GitHub Setup

1. Replace `YourGitHubUsername` with your actual GitHub username
2. Create a [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
3. Update the `gitHubAccessToken` with your username and token

#### Discord Setup (Optional)

1. Get your Discord User ID following the [Lanyard documentation](https://github.com/Phineas/lanyard)
2. Replace `YourDiscordUserID` in the constants

#### Medium Setup (Optional)

1. Find your Medium username (the part after @ in your Medium profile URL)
2. Replace `@YourMediumUsername` in the constants

### Running the Application

```bash
# Development
flutter run

# Web (recommended for this project)
flutter run -d chrome

# Build for web
flutter build web
```

## Project Structure

The project is organized following Clean Architecture principles:

### Data Layer

- **DataSources**: Handle API communications (GitHub, Discord, Medium)
- **Models**: Data transfer objects with JSON serialization
- **Repositories**: Implement domain repository interfaces

### Domain Layer

- **Entities**: Core business objects
- **Repositories**: Abstract interfaces for data access
- **UseCases**: Contain specific business logic

### Presentation Layer

- **Controllers**: Manage application state and business logic
- **Pages**: UI components and screens
- **Widgets**: Reusable UI components

## Features in Development

- [ ] Project thumbnail images
- [ ] Blog page integration with Medium
- [ ] Enhanced responsive design
- [ ] Additional social media integrations
- [ ] Performance optimizations

## Contributing

This project is in active development. Contributions, criticism, and suggestions are welcome!

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

## APIs Used

- **GitHub API**: For fetching profile information and repositories
- **Lanyard API**: For Discord presence status
- **RSS2JSON**: For Medium blog posts (planned)

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

If you find this project helpful, please consider giving it a ⭐ on GitHub!

---

**Note**: Make sure to keep your personal access tokens and sensitive information secure. Never commit them directly to your repository.
