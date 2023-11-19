// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/app/data/model/todo.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as Io;
import 'package:todo_app/app/data/services/socket.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString formattedDate = "".obs;
  var global = Get.put(GlobalController());
  final WebSocketController webSocketController =
      Get.put(WebSocketController());
  final count = 0.obs;
  var todos = List<Datum>.empty().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    updateDate();
    webSocketController.connectWebSocket();
    getTodo();
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
  void updateDate() {
    DateTime today = DateTime.now();
    String formattedString = DateFormat('MMMM d').format(today);
    formattedDate.value = formattedString;
  }

  getTodo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoading(true);
    update();
    try {
      final res = await http.get(
        Uri.parse(global.url + "/api/todo"),
        headers: {
          "Authorization":
              "Bearer ${preferences.getString("token").toString()}",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        Todo data = todoFromJson(res.body.toString());
        todos.value = data.data;
        print("${todos[0].name}");
      } else {
        Exception("Failed to load data");
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
