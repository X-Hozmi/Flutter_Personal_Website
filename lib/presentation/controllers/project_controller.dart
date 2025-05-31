import 'package:flutter_personal_website/domain/entities/project/project.dart';
import 'package:flutter_personal_website/domain/usecases/get_projects_usecase.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController {
  final GetProjects getProjectsUseCase;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final RxList<Project> _projects = RxList<Project>([]);

  RequestState get state => _state.value;
  String get message => _message.value;
  List<Project> get projects => _projects;

  ProjectController({required this.getProjectsUseCase});

  Future<void> getProjects() async {
    _state.value = RequestState.loading;
    update();

    final result = await getProjectsUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
        _projects.clear();
      },
      (success) {
        if (success.isEmpty) {
          _state.value = RequestState.empty;
          _message.value = 'No projects available yet.';
          _projects.clear();
        } else {
          _state.value = RequestState.loaded;
          _message.value = '';
          _projects.value = success;
        }
      },
    );

    update();
  }

  Future<void> refreshProjects() async {
    await getProjects();
  }

  void clearProjects() {
    _projects.clear();
    _state.value = RequestState.initial;
    _message.value = '';
    update();
  }
}
