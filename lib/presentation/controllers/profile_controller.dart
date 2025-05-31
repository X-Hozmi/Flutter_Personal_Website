import 'package:flutter_personal_website/domain/entities/profile/github_profile.dart';
import 'package:flutter_personal_website/domain/usecases/get_github_profile_usecase.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final GetGitHubProfile getGitHubProfileUseCase;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final Rxn<GitHubProfile> _gitHubProfile = Rxn<GitHubProfile>();

  RequestState get state => _state.value;
  String get message => _message.value;
  GitHubProfile? get gitHubProfile => _gitHubProfile.value;

  ProfileController({required this.getGitHubProfileUseCase});

  Future<void> getGitHubProfile() async {
    _state.value = RequestState.loading;
    update();

    final result = await getGitHubProfileUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
        _gitHubProfile.value = null;
      },
      (success) {
        _state.value = RequestState.loaded;
        _message.value = '';
        _gitHubProfile.value = success;
      },
    );

    update();
  }

  Future<void> refreshGitHubProfile() async {
    await getGitHubProfile();
  }

  void clearGitHubProfile() {
    _gitHubProfile.value = null;
    _state.value = RequestState.initial;
    _message.value = '';
    update();
  }
}
