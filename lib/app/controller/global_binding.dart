import 'package:get/get.dart';
import 'package:todo_app/app/modules/bottomBar/controllers/bottom_bar_controller.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/app/modules/loginPage/controllers/loginPage_controller.dart';
import 'package:todo_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:todo_app/app/modules/register/controllers/register_controller.dart';
import 'package:todo_app/app/modules/splashscreen/controllers/splashscreen_controller.dart';
import 'package:todo_app/app/modules/starter/controllers/starter_controller.dart';
import 'package:todo_app/app/modules/todo_list/controllers/todo_list_controller.dart';

class GlobalBindings extends Bindings{
    @override
    void dependencies() {
      Get.lazyPut(() => HomeController());
      Get.lazyPut(() => LoginPageController());
      Get.lazyPut(() => RegisterController());
      Get.lazyPut(() => SplashscreenController());
      Get.lazyPut(() => StarterController());
      Get.lazyPut(() => TodoListController());
      Get.lazyPut(() => BottomBarController());
      Get.lazyPut(() => ProfileController());
    }
}