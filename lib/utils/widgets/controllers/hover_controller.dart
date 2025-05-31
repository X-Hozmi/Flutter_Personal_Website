import 'package:get/get.dart';

class HoverController extends GetxController {
  final _isHovered = false.obs;

  bool get isHovered => _isHovered.value;

  void enter() => _isHovered.value = true;
  void exit() => _isHovered.value = false;
}
