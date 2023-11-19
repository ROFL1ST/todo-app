// ignore_for_file: must_be_immutable, prefer_const_constructors, sort_child_properties_last, annotate_overrides

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/loginPage/views/loginPage_view.dart';
import 'package:todo_app/app/modules/register/components/textField.dart';
import '../controllers/register_controller.dart';
import 'package:todo_app/config/common.dart';

class RegisterView extends GetView<RegisterController> {
  // ignore: use_key_in_widget_constructors
  RegisterView({Key? key}) : super(key: key);
  var global = Get.put(GlobalController());
  final controller = Get.put(RegisterController());

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
                        controller: controller.email,
                        decoration: InputDecoration(
                          icon: Container(
                            decoration: BoxDecoration(
                                color: kColor1,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Iconsax.sms,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
                        controller: controller.name,
                        decoration: InputDecoration(
                          icon: Container(
                            decoration: BoxDecoration(
                                color: kColor3,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Iconsax.user,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Name",
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
                            if (controller.email.value.text.length < 1 &&
                                controller.username.value.text.length < 1 &&
                                controller.name.value.text.length < 1 &&
                                controller.password.value.text.length < 1) {
                              Get.snackbar(
                                "Please fill in the blank",
                                "Please fill every form",
                                backgroundColor: Colors.black38,
                                duration: const Duration(milliseconds: 1300),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              controller.register();
                            }
                          }
                        },
                        child: Text(
                            controller.isLoading.value ? "Loading" : "Sign Up"),
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
                      onTap: () {
                        Get.offAllNamed("/login-screen");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Already Have An Account ? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Sign In",
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
