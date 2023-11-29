import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/modules/loginPage/views/loginPage_view.dart';

class StarterController extends GetxController {
  //TODO: Implement StarterController
  var currentIndex = 0.obs;
  final count = 0.obs;
  static List<Map<String, String>> staticList = [
    {
      'url': 'assets/json/starter-1.json',
      'title': 'The easiest way to make a todo with your friends.',
    },
    {
      'url': 'assets/json/starter-2.json',
      'title': 'The easiest way to make a todo with your friends.',
    },
    {
      'url': 'assets/json/starter-3.json',
      'title': 'The easiest way to make a todo with your friends.',
    }
  ];
  List<Map<String, String>> get getStaticList => staticList;
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

  void goToLogin() async {
    final storage = GetStorage();
    print("Going To Login");
    storage.write('firstTime', false);
    Get.offAllNamed("/register-screen");
  }
}
