import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/config/common.dart';
import 'package:todo_app/app/modules/starter/views/custom_dot.dart';
import '../controllers/starter_controller.dart';

class StarterView extends GetView<StarterController> {
  StarterView({Key? key}) : super(key: key);
  final controller = Get.put(StarterController());

  var global = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, index, realIndex) {
                  return cardCarousel(index);
                },
                options: CarouselOptions(
                  height: Get.height * 0.53,

                  initialPage: 0,
                  // enlargeCenterPage: true,
                  viewportFraction: 0.92,
                  onPageChanged: (index, reason) {
                    controller.updateCurrentPage(index);
                  },
                ),
              ),
              CustomDotIndicator(
                itemCount: 3, // Replace with your actual item count
                currentIndex: controller.currentIndex.value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardCarousel(index) {
    return Container(
      width: Get.width * 0.7,
      decoration: BoxDecoration(color: Colors.red),
      child: Center(child: Text("D")),
    );
  }
}
