// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/app/modules/loginPage/components/FieldController.dart';
import 'package:todo_app/app/modules/loginPage/controllers/loginPage_controller.dart';
import 'package:todo_app/config/common.dart';

class LoginPageView extends GetView<LoginPageController> {
  LoginPageView({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: Get.width / 4),
                  color: kBackgroundColor,
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
                ),
                SizedBox(
                  height: Get.height / 8,
                ),
                Column(
                  children: [
                    FieldController(
                      child: TextField(
                        controller: controller.username,
                        decoration: InputDecoration(
                          icon: Container(
                            decoration: BoxDecoration(
                              color: kColor2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Iconsax.user,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Username",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    FieldController(
                      child: TextField(
                        controller: controller.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Container(
                            decoration: BoxDecoration(
                                color: kColor4,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Iconsax.key,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Password",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          if (!controller.isLoading.value) {
                            if (controller.username.value.text.length < 1 &&
                                controller.password.value.text.length < 1) {
                              Get.snackbar(
                                "Please fill in the blank",
                                "Please fill every form",
                                backgroundColor: Colors.black38,
                                duration: const Duration(milliseconds: 1300),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              controller.login();
                            }
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Visibility(
                              visible: !controller.isLoading.value,
                              child: Text("Sign In"),
                            ),
                            Visibility(
                              visible: controller.isLoading.value,
                              child: SizedBox(
                                width: 20, // Adjust the width as needed
                                height: 20, // Adjust the height as needed
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          overlayColor: MaterialStateProperty.all(kButtonColor),
                          fixedSize: MaterialStateProperty.all(
                            Size(310, 50),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(kButtonColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot Your Password? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Reset Password",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
