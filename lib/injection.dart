import 'package:flutter_personal_website/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_personal_website/data/datasources/discord_presence_remote_data_source.dart';
import 'package:flutter_personal_website/data/datasources/github_snapshot_data_source.dart';
import 'package:flutter_personal_website/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_personal_website/data/datasources/project_remote_data_source.dart';
import 'package:flutter_personal_website/data/repositories/blog_repository_impl.dart';
import 'package:flutter_personal_website/data/repositories/discord_presence_repository_impl.dart';
import 'package:flutter_personal_website/data/repositories/profile_repository_impl.dart';
import 'package:flutter_personal_website/data/repositories/project_repository_impl.dart';
import 'package:flutter_personal_website/domain/repositories/blog_repository.dart';
import 'package:flutter_personal_website/domain/repositories/discord_presence_repository.dart';
import 'package:flutter_personal_website/domain/repositories/profile_repository.dart';
import 'package:flutter_personal_website/domain/repositories/project_repository.dart';
import 'package:flutter_personal_website/domain/usecases/get_blog_usecase.dart';
import 'package:flutter_personal_website/domain/usecases/get_discord_presence_usecase.dart';
import 'package:flutter_personal_website/domain/usecases/get_github_profile_usecase.dart';
import 'package:flutter_personal_website/domain/usecases/get_github_repos_usecase.dart';
import 'package:flutter_personal_website/presentation/controllers/blog_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/discord_presence_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/profile_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/project_controller.dart';
import 'package:flutter_personal_website/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Registers the application dependency graph using GetX's service locator.
///
/// Data sources, repositories, and use cases are marked with `fenix: true` so
/// they re-spawn after being disposed.
void init() {
  // Data Sources
  Get.lazyPut<GitHubSnapshotDataSource>(
    GitHubSnapshotDataSourceImpl.new,
    fenix: true,
  );
  Get.lazyPut<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: http.Client()),
    fenix: true,
  );
  Get.lazyPut<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(client: http.Client()),
    fenix: true,
  );
  Get.lazyPut<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(client: http.Client()),
    fenix: true,
  );
  Get.lazyPut<DiscordPresenceRemoteDataSource>(
    () => DiscordPresenceRemoteDataSourceImpl(client: http.Client()),
    fenix: true,
  );

  // Repositories
  Get.lazyPut<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: Get.find<ProfileRemoteDataSource>(),
      snapshotDataSource: Get.find<GitHubSnapshotDataSource>(),
    ),
    fenix: true,
  );
  Get.lazyPut<ProjectRepository>(
    () => ProjectRepositoryImpl(
      remoteDataSource: Get.find<ProjectRemoteDataSource>(),
      snapshotDataSource: Get.find<GitHubSnapshotDataSource>(),
    ),
    fenix: true,
  );
  Get.lazyPut<BlogRepository>(
    () => BlogRepositoryImpl(
      remoteDataSource: Get.find<BlogRemoteDataSource>(),
    ),
    fenix: true,
  );
  Get.lazyPut<DiscordPresenceRepository>(
    () => DiscordPresenceRepositoryImpl(
      remoteDataSource: Get.find<DiscordPresenceRemoteDataSource>(),
    ),
    fenix: true,
  );

  // Use Cases
  Get.lazyPut(
    () => GetGitHubProfile(Get.find<ProfileRepository>()),
    fenix: true,
  );
  Get.lazyPut(
    () => GetGitHubRepos(Get.find<ProjectRepository>()),
    fenix: true,
  );
  Get.lazyPut(() => GetBlogs(Get.find<BlogRepository>()), fenix: true);
  Get.lazyPut(
    () => GetDiscordPresence(Get.find<DiscordPresenceRepository>()),
    fenix: true,
  );

  // Controllers
  Get.lazyPut(
    () => ProfileController(
      getGitHubProfileUseCase: Get.find<GetGitHubProfile>(),
    ),
  );
  Get.lazyPut(
    () => ProjectController(getGitHubReposUseCase: Get.find<GetGitHubRepos>()),
  );
  Get.lazyPut(() => BlogController(getBlogsUseCase: Get.find<GetBlogs>()));
  Get.lazyPut(
    () => DiscordPresenceController(
      getDiscordPresenceUseCase: Get.find<GetDiscordPresence>(),
    ),
  );

  Get.put(ThemeController());
}
