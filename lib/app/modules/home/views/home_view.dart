// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty, sort_child_properties_last, non_constant_identifier_names

import 'dart:ffi';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/app/modules/home/components/start_button.dart';
import 'package:todo_app/config/common.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: RefreshIndicator(
            onRefresh: () async {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  Obx(
                    () => controller.isLoading.value
                        ? Shimmer.fromColors(
                            child: Container(),
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.white)
                        : controller.todos.length != 0
                            ? TodoList()
                            : SizedBox(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  StaggeredGrid TodoList() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: Get.height * 0.01,
      crossAxisSpacing: Get.width * 0.02,
      children: [
        _cardFirst(controller.todos[0]),
        ...controller.todos
            .skip(1)
            .take(2)
            .toList()
            .asMap()
            .map(
              (index, e) => MapEntry(
                index,
                _cardSecond(index, e),
              ),
            )
            .values
            .toList(),
      ],
    );
  }

  Widget _cardFirst(data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: kColor1,
      child: Container(
        width: Get.width / 2 - 1,
        height: Get.height * 0.38,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Iconsax.edit, size: Get.width * 0.07),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  AutoSizeText(
                    data.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  AutoSizeText(
                    data.description,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i < (data.user.length < 4 ? data.user.length : 4);
                            i++)
                          Align(
                            widthFactor: 0.5,
                            child: CircleAvatar(
                              radius: Get.width * 0.055,
                              backgroundImage: CachedNetworkImageProvider(
                                  data.user[i].photoProfile != ""
                                      ? data.user[i].photoProfile
                                      : "https://pbs.twimg.com/media/F_Y94uqbwAANeI3?format=jpg&name=small",
                                  cacheKey: data.user[i].photoProfile != ""
                                      ? data.user[i].photoProfile
                                      : "https://pbs.twimg.com/media/F_Y94uqbwAANeI3?format=jpg&name=small"),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  StepProgressIndicator(
                    totalSteps: 100,
                    currentStep: int.parse(data.percent),
                    size: Get.height * 0.01,
                    padding: 0,
                    roundedEdges: Radius.circular(10),
                    direction: Axis.horizontal,
                    progressDirection: ui.TextDirection.rtl,
                    selectedColor: ui.Color.fromARGB(255, 126, 32, 32),
                    unselectedColor: Color(0xFFD9D9D9).withOpacity(0.4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('${int.parse(data.percent).ceil()}%')],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardSecond(index, data) {
    return Card(
      color: index == 1 ? kColor2 : kColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: Get.width / 2 - 1,
        height: Get.height * 0.18,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Iconsax.edit, size: Get.width * 0.06),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  AutoSizeText(
                    data.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i < (data.user.length < 4 ? data.user.length : 4);
                            i++)
                          Align(
                            widthFactor: 0.5,
                            child: CircleAvatar(
                              radius: Get.width * 0.035,
                              backgroundImage: CachedNetworkImageProvider(
                                  data.user[i].photoProfile != ""
                                      ? data.user[i].photoProfile
                                      : "https://pbs.twimg.com/media/F_Y94uqbwAANeI3?format=jpg&name=small",
                                  cacheKey: data.user[i].photoProfile != ""
                                      ? data.user[i].photoProfile
                                      : "https://pbs.twimg.com/media/F_Y94uqbwAANeI3?format=jpg&name=small"),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  StepProgressIndicator(
                    totalSteps: 100,
                    currentStep: int.parse(data.percent),
                    size: Get.height * 0.01,
                    padding: 0,
                    roundedEdges: Radius.circular(10),
                    direction: Axis.horizontal,
                    progressDirection: ui.TextDirection.rtl,
                    selectedColor: ui.Color.fromARGB(255, 126, 32, 32),
                    unselectedColor: Color(0xFFD9D9D9).withOpacity(0.4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('${int.parse(data.percent).ceil()}%')],
                  )
                ],
              )
            ],
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
}
