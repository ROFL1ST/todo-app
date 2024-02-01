// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/config/common.dart';

class LeaveModal extends StatefulWidget {
  // Declare the overlay as a parameter

  // Use the required keyword for required parameters in the constructor
  const LeaveModal({Key? key, required this.data}) : super(key: key);
  final data;
  @override
  State<LeaveModal> createState() => _LeaveModalState();
}

class _LeaveModalState extends State<LeaveModal> {
  final storage = GetStorage();

  final controller = Get.put(
    HomeController(),
  );
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Leave ${widget.data.name}'),
      content: Text('Are you sure you want to leave this ${widget.data.name}?'),
      actions: [
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Obx(
          () => CupertinoDialogAction(
            isDestructiveAction: true,
            child:
                controller.isLoading7.value ? Text('Loading') : Text('Leave'),
            onPressed: () {
              // Handle delete action
              controller.kickUser(
                  Jwt.parseJwt(storage.read("token"))["id"].toString(),
                  widget.data.id,
                  widget.data.name,
                  context);
            },
          ),
        )
      ],
    );
  }
}
