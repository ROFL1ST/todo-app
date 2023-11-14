// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/modules/loginPage/controllers/loginPage_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  LoginPageView({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Center(
          child: Text(
            'LoginPage is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
