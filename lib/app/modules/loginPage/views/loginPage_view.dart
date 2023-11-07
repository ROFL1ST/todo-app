import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/modules/loginPage/controllers/loginPage_controller.dart';



class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LoginPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
