// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/app/modules/home/views/home_view.dart';

class LoginPageController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var global = Get.put(GlobalController());
  var isLoading = false.obs;

  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  login() async {
    update();
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(global.url + "/api/login"),
        body: json.encode(
          {
            "username": username.text,
            "password": password.text,
          },
        ),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        global.setToken(json.decode(response.body)['token']);
        Get.showSnackbar(
          GetSnackBar(
            titleText: Text("Success"),
            messageText: Text("You have been logged"),
            backgroundColor: Colors.black38,
            duration: const Duration(milliseconds: 1300),
            snackPosition: SnackPosition.TOP,
            barBlur: 5,
          ),
        );
        Timer(Duration(milliseconds: 750), () {
          Get.offAll(() => HomeView(),
              duration: Duration(milliseconds: 1500),
              transition: Transition.zoom);
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
      print("Error : ${e}");
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
