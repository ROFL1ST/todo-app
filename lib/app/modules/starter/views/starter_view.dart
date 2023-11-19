import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/config/common.dart';
import 'package:todo_app/app/modules/starter/views/custom_dot.dart';
import '../controllers/starter_controller.dart';

class StarterView extends GetView<StarterController> {
  StarterView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(StarterController());
  var global = Get.put(GlobalController());
  final CarouselController _carouselController = CarouselController();

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
                carouselController: _carouselController,
                itemCount: 3,
                itemBuilder: (BuildContext context, index, realIndex) {
                  return cardCarousel(index, controller.getStaticList);
                },
                options: CarouselOptions(
                  height: Get.height * 0.53,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  // enlargeCenterPage: true,
                  viewportFraction: 0.92,
                  onPageChanged: (index, reason) {
                    controller.updateCurrentPage(index);
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Obx(
                () => CustomDotIndicator(
                  itemCount: 3, // Replace with your actual item count
                  currentIndex: controller.currentIndex.value,
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.currentIndex.value != 2) {
                    _carouselController.animateToPage(
                      controller.currentIndex.value + 1,
                      curve: Curves.easeInOut,
                    );
                  } else {
                    controller.goToLogin();
                  }
                },
                child: Obx(() => Text(controller.currentIndex.value != 2
                    ? "Next"
                    : "Get Started")),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(kButtonColor),
                    fixedSize: MaterialStateProperty.all(Size(270, 50)),
                    backgroundColor: MaterialStateProperty.all(kButtonColor)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardCarousel(index, data) {
    return Container(
      width: Get.width * 0.7,
      // decoration: BoxDecoration(color: Colors.red),
      child: Center(
          child: Column(
        children: [
          LottieBuilder.asset(data[index]["url"].toString()),
          Text(
            data[index]["title"].toString(),
            style: TextStyle(
                fontFamily: "popinsemi",
                fontSize: Get.width / 17,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
