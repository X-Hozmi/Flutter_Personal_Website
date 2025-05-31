import 'package:flutter_personal_website/domain/entities/blog/blog.dart';
import 'package:flutter_personal_website/domain/usecases/get_blog_usecase.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  final GetBlogs getBlogsUseCase;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final RxList<Blog> _blogs = RxList<Blog>([]);

  RequestState get state => _state.value;
  String get message => _message.value;
  List<Blog> get blogs => _blogs;

  BlogController({required this.getBlogsUseCase});

  Future<void> getBlogs() async {
    _state.value = RequestState.loading;
    update();

    final result = await getBlogsUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
        _blogs.clear();
      },
      (success) {
        if (success.isEmpty) {
          _state.value = RequestState.empty;
          _message.value = 'No blog posts available yet.';
          _blogs.clear();
        } else {
          _state.value = RequestState.loaded;
          _message.value = '';
          _blogs.value = success;
        }
      },
    );

    update();
  }

  Future<void> refreshBlogs() async {
    await getBlogs();
  }

  void clearBlogs() {
    _blogs.clear();
    _state.value = RequestState.initial;
    _message.value = '';
    update();
  }
}
