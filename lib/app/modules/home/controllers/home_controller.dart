// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/app/data/model/todo.dart' as Todo;
import 'package:todo_app/app/data/model/todoAllList.dart' as TodoAllList;
import 'package:todo_app/app/data/model/friends.dart' as Friends;
import 'package:http/http.dart' as http;
import 'package:todo_app/app/data/services/socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:todo_app/app/helper/hero_dialogue_route.dart';
import 'package:todo_app/app/modules/home/components/delete_modal.dart';
import 'package:todo_app/app/modules/home/components/edit_modal.dart';
import 'package:todo_app/app/modules/home/components/friends_card.dart';
import 'package:todo_app/config/common.dart';

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
  var friendList = List<Friends.Datum>.empty().obs;
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var isLoading3 = false.obs;
  var isLoading4 = false.obs;
  double keyboardHeight = 0.0;

  IO.Socket? socket;
  final storage = GetStorage();

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController search = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    updateDate();
    getTodo();
    getAllList();
    getUpdatedList();
    getFriend();
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
      if (res.statusCode == 200) {
        Todo.Todo data = Todo.todoFromJson(res.body.toString());
        log("${data.data}");
        todos.value = data.data;
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

  getUpdatedList() async {
    IO.Socket socket = IO.io("${global.url}/api/socket", <String, dynamic>{
      "transports": ["websocket"]
    });
    socket.onConnect((data) {
      socket.on("todoListNew", (data) async {
        List<TodoAllList.Datum> newData = (data as List<dynamic>).map((item) {
          return TodoAllList.Datum.fromJson(item);
        }).toList();
        bool isTodoExist = todos.any((todo) => todo.id == newData[0].idTodo);
        if (isTodoExist) {
          // Update the allList variable
          allList.addAll(newData);
        }
        await getProgress();
      });
      socket.on("todoListUpdated", (data) async {
        // Assuming data is a list of items
        List<dynamic> dataList = data;

        for (var item in dataList) {
          // Assuming item is a Map<String, dynamic>
          Map<String, dynamic> itemMap = item;

          // Assuming you have a TodoAllList.Datum.fromJson method to convert the map to your model
          TodoAllList.Datum newData = TodoAllList.Datum.fromJson(itemMap);

          // Find the index of the item with the same id in both lists
          int indexAllList =
              allList.indexWhere((item) => item.id == newData.id);
          int indexAllListCompleted =
              allListCompleted.indexWhere((item) => item.id == newData.id);

          if (newData.status == "completed") {
            // Add or update the item in allListCompleted
            if (indexAllListCompleted != -1) {
              allListCompleted[indexAllListCompleted] = newData;
            } else {
              allListCompleted.add(newData);
            }
          } else if (newData.status == "open") {
            if (indexAllListCompleted != -1) {
              // If the item is found in allListCompleted, remove it
              allListCompleted.removeAt(indexAllListCompleted);
            }

            // Add or update the item in allList
            if (indexAllList != -1) {
              allList[indexAllList] = newData;
            } else {
              allList.add(newData);
            }
          }
        }
        await getProgress();
      });
      socket.on("todoListDeleted", (data) async {
        print(data);
        allList.removeWhere((item) => item.id == data);
        await getProgress();
      });
    });
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
    update();
  }

  addTodo(BuildContext context) async {
    update();
    isLoading3(true);
    try {
      final token = storage.read("token").toString();
      final headers = {
        "Authorization": "Bearer $token",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      if (name.text == "") {
        Get.showSnackbar(
          GetSnackBar(
            titleText: Text("Failed"),
            messageText: Text("Please insert the name of your todo"),
            backgroundColor: Colors.black38,
            duration: const Duration(milliseconds: 1300),
            snackPosition: SnackPosition.TOP,
            barBlur: 5,
          ),
        );
      } else {
        final res = await http.post(
          Uri.parse(global.url + "/api/todo"),
          body: json.encode(
            {
              "name": name.text,
              "description": description.text,
            },
          ),
          headers: headers,
        );
        if (description.text == "") {
          Get.showSnackbar(
            GetSnackBar(
              titleText:
                  Text("Failed", style: TextStyle(fontWeight: FontWeight.bold)),
              messageText: Text(
                "Please insert the description of ${name.text}",
              ),
              backgroundColor: Colors.black38,
              duration: const Duration(milliseconds: 1300),
              snackPosition: SnackPosition.TOP,
              barBlur: 5,
            ),
          );
        } else {
          if (res.statusCode == 200) {
            Get.showSnackbar(
              GetSnackBar(
                titleText: Text(
                  "Success 😊",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                messageText: Text("Your ${name.text} has been added"),
                backgroundColor: Colors.black38,
                duration: const Duration(milliseconds: 1300),
                snackPosition: SnackPosition.TOP,
                barBlur: 5,
              ),
            );
            getTodo();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        }
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
      isLoading3(false);
    }
  }

  getFriend() async {
    update();
    isLoading4(true);
    try {
      final token = storage.read("token").toString();
      final headers = {
        "Authorization": "Bearer $token",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final result = await http.get(
        Uri.parse("${global.url}/api/friends"),
        headers: headers,
      );
      if (result.statusCode == 200) {
        Friends.Friends data = Friends.friendsFromJson(result.body.toString());
        friendList.value = data.data;
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
    }
  }

  modalMenu(BuildContext outerContext, data) {
    var user = data.user.firstWhere(
      (user) =>
          user.idUser == Jwt.parseJwt(storage.read("token"))["id"].toString(),
    );
    log("${user.role}");
    BuildContext scaffoldContext;
    showModalBottomSheet(
      backgroundColor: kBackgroundColor,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(outerContext).size.width / 20),
          topRight:
              Radius.circular(MediaQuery.of(outerContext).size.width / 20),
        ),
      ),
      context: outerContext,
      builder: (context) {
        scaffoldContext = context;
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Get.width / 50),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                  height: 4, // Adjust the height of the line as needed
                  width: Get.width / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  // Change the color of the line
                ),
                (user.role != "member")
                    ? ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Icon(
                          IconlyBold.edit,
                          color: kEdit,
                        ),
                        title: Text(
                          "Edit",
                          style: TextStyle(color: kEdit),
                        ),
                        onTap: () {
                          // Handle edit action
                          Navigator.pop(scaffoldContext);

                          Navigator.of(context)
                              .push(HeroDialogRoute(builder: (context) {
                            return EditModal();
                          }));
                        },
                      )
                    : SizedBox(),
                (user.role == "owner")
                    ? ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Icon(
                          IconlyBold.delete,
                          color: kDelete,
                        ),
                        title: Text(
                          "Delete",
                          style: TextStyle(color: kDelete),
                        ),
                        onTap: () async {
                          // Handle delete action
                          Navigator.pop(scaffoldContext);

                          Navigator.of(context)
                              .push(HeroDialogRoute(builder: (context) {
                            return DeleteModal();
                          }));

                          // Close the bottom sheet using the stored scaffold's context
                        },
                      )
                    : SizedBox(),
                (user.role != "member")
                    ? ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Icon(
                          IconlyBold.add_user,
                          color: kInvite,
                        ),
                        title: Text(
                          "Invite",
                          style: TextStyle(color: kInvite),
                        ),
                        onTap: () {
                          // Handle invite action
                          Navigator.pop(scaffoldContext);

                          inviteModal(context, data.user); // Close the bottom sheet
                        },
                      )
                    : SizedBox(),
                (user.role == "owner")
                    ? ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Icon(
                          IconlyBold.logout,
                          color: kKick,
                        ),
                        title: Text(
                          "Kick",
                          style: TextStyle(color: kKick),
                        ),
                        onTap: () {
                          // Handle kick action
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      )
                    : ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: Icon(
                          IconlyBold.logout,
                          color: kKick,
                        ),
                        title: Text(
                          "Leave",
                          style: TextStyle(color: kKick),
                        ),
                        onTap: () {
                          // Handle kick action
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  inviteModal(BuildContext outerContext, data) {
    BuildContext scaffoldContext;
    double keyboardHeight = MediaQuery.of(outerContext).viewInsets.bottom;
    
    showModalBottomSheet(
      backgroundColor: kBackgroundColor,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(outerContext).size.width / 20),
          topRight:
              Radius.circular(MediaQuery.of(outerContext).size.width / 20),
        ),
      ),
      context: Get.context!,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: Get.height * 0.8,
            padding: EdgeInsets.only(
              left: Get.width / 20,
              right: Get.width / 20,
              top: Get.width / 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                  height: 4, // Adjust the height of the line as needed
                  width: Get.width / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  // Change the color of the line
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8),
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                        icon: Icon(
                          Iconsax.search_normal,
                          color: Colors.white,
                        ),
                        hintText: "Search your friend",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: friendList.length,
                  itemBuilder: (context, index) {
                    return FriendCard(friendList: friendList, index: index);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void updateKeyboardHeight(double height) {
    keyboardHeight = height;
    update(); // This will trigger a rebuild of the UI
  }
}
