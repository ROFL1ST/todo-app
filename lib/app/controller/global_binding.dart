import 'package:get/get.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/app/modules/loginPage/controllers/loginPage_controller.dart';
import 'package:todo_app/app/modules/register/controllers/register_controller.dart';
import 'package:todo_app/app/modules/splashscreen/controllers/splashscreen_controller.dart';
import 'package:todo_app/app/modules/starter/controllers/starter_controller.dart';

class GlobalBindings extends Bindings{
    @override
    void dependencies() {
      Get.lazyPut(() => HomeController());
      Get.lazyPut(() => LoginPageController());
      Get.lazyPut(() => RegisterController());
      Get.lazyPut(() => SplashscreenController());
      Get.lazyPut(() => StarterController());
    }
}