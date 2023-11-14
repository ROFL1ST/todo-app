import 'package:get/get.dart';

import '../controllers/starter_controller.dart';

class StarterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarterController>(
      () => StarterController(),
    );
  }
}
