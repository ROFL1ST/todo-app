import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todo_app/app/modules/loginPage/views/loginPage_view.dart';
import 'package:todo_app/app/modules/register/views/register_view.dart';
import 'package:todo_app/app/modules/starter/views/starter_view.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController
  final global = Get.put(GlobalController());
  // final profileController = Get.put(ProfileController());
  late SharedPreferences prefs;

  var opacity = 0.0.obs;
  @override
  void onInit() async {
    ConnectivityResult? check;
    super.onInit();
    check = await Connectivity().checkConnectivity();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (check == ConnectivityResult.mobile ||
        check == ConnectivityResult.wifi) {
      global.isOnline(true);
      update();
    }
    checkFirstTime();
    checkToken();
  }

  @override
  void onReady() {
    super.onReady();
    opacity.value = 1.0;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkFirstTime() async {
    prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime') ?? true;

    Timer(Duration(seconds: 3), () {
      if (firstTime) {
        
        Get.off(() => StarterView(), transition: Transition.fade);
      } else {
        checkToken();
      }
    });
  }

  checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (global.isOnline.isTrue) {
      Timer(Duration(seconds: 3), () {
        if (token != null) {
          final isTokenExpired = JwtDecoder.isExpired(token);
          if (!isTokenExpired) {
            // Get.off(() => BottomBarView(),
            //     duration: Duration(milliseconds: 1000),
            //     transition: Transition.fade);
          } else {
            Get.dialog(
              barrierDismissible: false,
              transitionCurve: Curves.fastLinearToSlowEaseIn,
              AlertDialog(
                title: Text('Token Kadaluarsa'),
                content:
                    Text('Sesi Loginmu Telah Berakhir. Harap Login Kembali.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.offAll(() => LoginPageView(),
                          duration: Duration(milliseconds: 1000),
                          transition: Transition.leftToRightWithFade);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          Get.offAll(
            () => RegisterView(),
          );
        }
      });
    } else {
      return Get.dialog(
        barrierDismissible: false,
        transitionCurve: Curves.fastLinearToSlowEaseIn,
        AlertDialog(
          title: Text(
            'Offline',
          ),
          content: Text(
            'Aplikasi Membutuhkan Internet. Mohon Coba Lagi',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.deleteAll();
                onInit();
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }
}
