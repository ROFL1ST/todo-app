// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/app/data/model/notifications.dart' as Notifs;

class BottomBarController extends GetxController {
  //TODO: Implement BottomBarController
  var global = Get.put(GlobalController());
  final storage = GetStorage();
  var notifs = List<Notifs.Datum>.empty().obs;
  final count = 0.obs;
  var tabIndex = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotif();
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

  getNotif() async {
    isLoading(true);
    update();
    try {
      final res = await http.get(
        Uri.parse("${global.url}/api/notifications"),
        headers: {
          "Authorization": "Bearer ${storage.read("token").toString()}",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        Notifs.Notifications data = Notifs.notificationsFromJson(res.body.toString());
        notifs.value = data.data;
      }
    } catch (e) {
      log("$e");
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
    } finally {
      update();
      isLoading(false);
    }
  }
}
