// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/app/modules/loginPage/views/loginPage_view.dart';

class RegisterController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  var global = Get.put(GlobalController());
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  register() async {
    update();
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(global.url + "/api/register"),
        body: json.encode({
          "email": email.text,
          "username": username.text,
          "name": name.text,
          "password": password.text
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Get.showSnackbar(
          GetSnackBar(
            titleText: Text("Success"),
            messageText: Text(
                "Verification has been sent to your email, please verify you email!"),
            backgroundColor: Colors.black38,
            duration: const Duration(milliseconds: 1300),
            snackPosition: SnackPosition.TOP,
            barBlur: 5,
          ),
        );
        Timer(Duration(milliseconds: 750), () {
          Get.offAll(() => LoginPageView(),
              duration: Duration(milliseconds: 1500),
              transition: Transition.rightToLeftWithFade);
          Timer(Duration(seconds: 4), () {
            isLoading(false);
            update();
          });
        });
      } else {
        update();
        isLoading(false);
        Get.showSnackbar(
          GetSnackBar(
            titleText: Text("There's been some mistake", style: TextStyle(fontWeight: FontWeight.bold),),
            messageText: Text(
              json.decode(response.body)['message'].toString(),
            ),
            backgroundColor: Colors.black38,
            duration: const Duration(milliseconds: 2300),
            snackPosition: SnackPosition.TOP,
            barBlur: 5,
          ),
        );
      }
    } catch (e) {
      print(e);
      update();
      isLoading(false);
      Get.showSnackbar(
        GetSnackBar(
          titleText: Text("There's been some mistake"),
          messageText: Text(
            "Please try again later",
          ),
          backgroundColor: Colors.black38,
          duration: const Duration(milliseconds: 1300),
          snackPosition: SnackPosition.TOP,
          barBlur: 5,
        ),
      );
    }
  }
}
