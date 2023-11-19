import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
  // var profile = Get.put(ProfileController());
  final url = 'https://todo-mongo-api-production.up.railway.app';
  final fontHeading = 27.0.obs;
  final fontSize = 18.0.obs;
  final fontSet = 13.0.obs;
  final fontSmall = 10.0.obs;
  final format =
      NumberFormat.currency(locale: 'ID', symbol: 'Rp ', decimalDigits: 0).obs;

  final isDark = false.obs;
  var isOnline = false.obs;
  final token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.width <= 360) {
      fontHeading.value = 27.0;
      fontSize.value = 18.0;
      fontSet.value = 13.0;
      fontSmall.value = 10;
    } else if (Get.width > 360 && Get.width <= 720) {
      fontHeading.value = 30.0;
      fontSize.value = 21.0;
      fontSet.value = 16.0;
      fontSmall.value = 13.0;
    } else {
      fontHeading.value = 33.0;
      fontSize.value = 24.0;
      fontSet.value = 19.0;
      fontSmall.value = 16.0;
    }


    
    // initApp();
  }

  @override
  void onReady() {
    super.onReady();
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void onClose() {}

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token').toString();
  }

  setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  void connection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isOnline(true);
        update();
      } else {
        isOnline(false);
        update();
      }
    } catch (e) {
      isOnline(false);
      update();
    }
  }

  change() {
    isDark.value = !isDark.value;
    update();
    if (isDark.value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else
      Get.changeThemeMode(ThemeMode.light);
  }
  // initApp() async => await profile.getUserProfile(getToken().toString());

 
    // await AwesomeNotifications().isNotificationAllowed().then(
    //   (isAllowed) {
    //     print("$isAllowed  sdfsfdsf");
    //     if (!isAllowed) {
    //       Get.dialog(
    //         barrierDismissible: true,
    //         transitionCurve: Curves.fastLinearToSlowEaseIn,
    //         AlertDialog(
    //           title: Text('Izinkan Notifikasi.'),
    //           content: Text('SIPAOJOL Meminta Untuk Memberikan Notifikasi.'),
    //           actions: [
    //             TextButton(
    //               onPressed: () => Get.back(),
    //               child: Text(
    //                 'Jangan Izinkan',
    //                 style: TextStyle(color: greeny),
    //               ),
    //             ),
    //             TextButton(
    //               onPressed: () => AwesomeNotifications()
    //                   .requestPermissionToSendNotifications()
    //                   .then((_) => Get.back()),
    //               child: Text(
    //                 'Izinkan',
    //                 style: TextStyle(color: greeny),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //       // showDialog(
    //       //   context: context,
    //       //   builder: (context) => AlertDialog(
    //       //     title: Text('Allow Notifications'),
    //       //     content: Text('Our app would like to send you notifications'),
    //       //     actions: [
    //       //       TextButton(
    //       //         onPressed: () {
    //       //           Navigator.pop(context);
    //       //         },
    //       //         child: Text(
    //       //           'Don\'t Allow',
    //       //           style: TextStyle(color: Colors.grey, fontSize: 18),
    //       //         ),
    //       //       ),
    //       //       TextButton(
    //       //         onPressed: () => AwesomeNotifications()
    //       //             .requestPermissionToSendNotifications()
    //       //             .then((_) => Navigator.pop(context)),
    //       //         child: Text(
    //       //           'Allow',
    //       //           style: TextStyle(
    //       //             color: Colors.teal,
    //       //             fontSize: 18,
    //       //             fontWeight: FontWeight.bold,
    //       //           ),
    //       //         ),
    //       //       ),
    //       //     ],
    //       //   ),
    //       // );
    //     }
    //   },
    // );
  }

  
