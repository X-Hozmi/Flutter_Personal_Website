import 'package:flutter_personal_website/domain/entities/github_repo.dart';
import 'package:flutter_personal_website/domain/usecases/get_github_repos_usecase.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController {
  final GetGitHubRepos getGitHubReposUseCase;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final RxList<GitHubRepo> _repos = RxList<GitHubRepo>([]);

  RequestState get state => _state.value;
  String get message => _message.value;
  List<GitHubRepo> get repos => _repos;

  ProjectController({required this.getGitHubReposUseCase});

  @override
  void onInit() {
    super.onInit();
    getGitHubRepos();
  }

  Future<void> getGitHubRepos() async {
    _state.value = RequestState.loading;
    update();

    final result = await getGitHubReposUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
        _repos.clear();
      },
      (success) {
        final visibleRepos =
            success.where((repo) => !repo.isFork && !repo.isArchived).toList();

        if (visibleRepos.isEmpty) {
          _state.value = RequestState.empty;
          _message.value = 'No public repositories available yet.';
          _repos.clear();
        } else {
          _state.value = RequestState.loaded;
          _message.value = '';
          _repos.value = visibleRepos;
        }
      },
    );

    update();
  }

  Future<void> refreshProjects() => getGitHubRepos();

  void clearProjects() {
    _repos.clear();
    _state.value = RequestState.initial;
    _message.value = '';
    update();
  }
}
