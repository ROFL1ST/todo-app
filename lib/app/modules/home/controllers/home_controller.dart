// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:developer';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/app/data/model/todo.dart' as Todo;
import 'package:todo_app/app/data/model/todoAllList.dart' as TodoAllList;
import 'package:http/http.dart' as http;
import 'package:todo_app/app/data/services/socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString formattedDate = "".obs;
  var global = Get.put(GlobalController());
  final WebSocketController webSocketController =
      Get.put(WebSocketController());
  final progress = 0.obs;
  var todos = List<Todo.Datum>.empty().obs;
  var allList = List<TodoAllList.Datum>.empty().obs;
  var allListCompleted = List<TodoAllList.Datum>.empty().obs;
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  Io.Socket? socket;
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    updateDate();
    getTodo();
    getAllList();
  }

  @override
  void onReady() {
    super.onReady();
    // webSocketController.connectWebSocket();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateDate() {
    DateTime today = DateTime.now();
    String formattedString = DateFormat('MMMM d').format(today);
    formattedDate.value = formattedString;
  }

 
  getTodo() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist("API_TODO");
    isLoading(true);
    update();
    try {
      final res = await http.get(
        Uri.parse("${global.url}/api/todo"),
        headers: {
          "Authorization": "Bearer ${storage.read("token").toString()}",
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (!isCacheExist) {
        if (res.statusCode == 200) {
          APICacheDBModel cacheDBModel = new APICacheDBModel(
              key: "API_TODO", syncData: res.body.toString());
          await APICacheManager().addCacheData(cacheDBModel);
          Todo.Todo data = Todo.todoFromJson(res.body.toString());
          todos.value = data.data;
        } else {
          Exception("Failed to load data");
        }
      } else {
        var cacheData = await APICacheManager().getCacheData("API_TODO");
        Todo.Todo data = Todo.todoFromJson(cacheData.syncData);
        todos.value = data.data;
        print("HIT");
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

  getAllList() async {
    isLoading2(true);
    update();

    try {
      final token = storage.read("token").toString();
      final headers = {
        "Authorization": "Bearer $token",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final result = await http.get(
        Uri.parse("${global.url}/api/todos/list"),
        headers: headers,
      );

      final result2 = await http.get(
        Uri.parse("${global.url}/api/todos/list?status=completed"),
        headers: headers,
      );

      if (result.statusCode == 200) {
        TodoAllList.TodoAllList data =
            TodoAllList.todoAllListFromJson(result.body.toString());
        allList.value = data.data;
      } else {
        throw Exception("Failed to load data");
      }

      if (result2.statusCode == 200) {
        TodoAllList.TodoAllList data =
            TodoAllList.todoAllListFromJson(result2.body.toString());
        allListCompleted.value = data.data;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      log("$e");
      Get.showSnackbar(
        GetSnackBar(
          titleText: Text("There's been some mistake"),
          messageText: Text("Please try again later"),
          backgroundColor: Colors.black38,
          duration: const Duration(milliseconds: 1300),
          snackPosition: SnackPosition.TOP,
          barBlur: 5,
        ),
      );
    } finally {
      update();
      isLoading2(false);
      getProgress();
    }
  }

  getProgress() {
    if (!isLoading2.value) {
      if (allList.isNotEmpty) {
        progress.value =
            ((allListCompleted.length / allList.length) * 100).toInt();
        log("${progress.value}");
      }
    }
  }
}
