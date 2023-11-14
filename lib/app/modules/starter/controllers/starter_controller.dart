import 'package:get/get.dart';

class StarterController extends GetxController {
  //TODO: Implement StarterController
  var currentIndex = 0.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  // add prefs.setBool('firstTime', false);
  void updateCurrentPage(index) {
    currentIndex.value = index;
  }
}
