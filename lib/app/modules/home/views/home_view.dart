// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/app/modules/home/components/start_button.dart';
import 'package:todo_app/config/common.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [],
          body: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Icon(Iconsax.category),
                        ),
                        GestureDetector(
                          child: Icon(Iconsax.notification),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      "Hi, danendra",
                      style: TextStyle(fontSize: Get.width * 0.06),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      "Let’s see what we can do\ntoday!",
                      style: TextStyle(
                          fontSize: Get.width * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    StartButton(),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Progress(),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container Progress() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      width: Get.width,
      decoration: BoxDecoration(
        color: kBgForm,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Todo Progress",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text("25/52 Done"),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      child: Obx(
                        () => Text(
                          "${controller.formattedDate.value}",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      )),
                )
              ],
            ),
            SimpleCircularProgressBar(
              size: Get.height * 0.07,
              progressStrokeWidth: 10,
              backStrokeWidth: 10,
              mergeMode: true,
              onGetText: (value) {
                return Text(
                  '${value.toInt()}%',
                );
              },
              progressColors: const [Colors.purple, kButtonColor],
              backColor: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }

  String getCurrentMonth() {
    DateTime now = DateTime.now();
    String month = '${now.month}';
    return month;
  }
}
