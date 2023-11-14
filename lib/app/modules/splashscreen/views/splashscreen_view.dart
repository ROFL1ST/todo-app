import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/app/helper/cache_image_with_cachemanager.dart';

import '../controllers/splashscreen_controller.dart';
import 'package:todo_app/config/common.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  SplashscreenView({Key? key}) : super(key: key);
  final controller = Get.put(SplashscreenController());
  var global = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: Get.width / 2),
        color: kBackgroundColor,
        child: Obx(() => AnimatedOpacity(
              curve: Curves.easeInBack,
              duration: Duration(milliseconds: 2500),
              opacity: controller.opacity.value,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(),
                    Image.asset(
                      "assets/icons/icon.png",
                      width: Get.width / 2.5,
                    ),
                    Text(
                      'Let’s be productive',
                      style: TextStyle(
                          fontSize: Get.width / 20,
                          fontFamily: 'Prompt',
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
