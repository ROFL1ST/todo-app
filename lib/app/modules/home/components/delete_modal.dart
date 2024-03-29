// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/config/common.dart';

class DeleteModal extends StatefulWidget {
  // Declare the overlay as a parameter

  // Use the required keyword for required parameters in the constructor
  const DeleteModal({Key? key, required this.data}) : super(key: key);
  final data;
  @override
  State<DeleteModal> createState() => _DeleteModalState();
}

class _DeleteModalState extends State<DeleteModal> {
  final controller = Get.put(
    HomeController(),
  );
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Delete Item'),
      content: Text('Are you sure you want to delete this item?'),
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
                controller.isLoading7.value ? Text('Loading') : Text('Delete'),
            onPressed: () {
              // Handle delete action
              log("${widget.data.id}");
              controller.deleteTodo(widget.data.id, widget.data.name, context);
            },
          ),
        )
      ],
    );
  }
}
