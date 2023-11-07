import 'package:get/get.dart';
import 'package:todo_app/app/modules/loginPage/controllers/loginPage_controller.dart';



class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(
      () => LoginPageController(),
    );
  }
}
