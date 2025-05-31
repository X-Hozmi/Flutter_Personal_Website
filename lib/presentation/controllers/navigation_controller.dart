import 'package:flutter_personal_website/utils/constant.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var tabIndex = 0.obs;
  var currentRoute = Routes.homePage.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    switch (index) {
      case 0:
        currentRoute.value = Routes.homePage;
        break;
      case 1:
        currentRoute.value = Routes.projectPage;
        break;
      case 2:
        currentRoute.value = Routes.blogPage;
        break;
    }
  }
}
