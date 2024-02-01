// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';

class EditModal extends StatefulWidget {
  const EditModal({super.key, required this.data});
  final data;
  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  final controller = Get.put(
    HomeController(),
  );
  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.data.name;
    description.text = widget.data.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Edit Item'),
      content: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8),
                child: CupertinoTextField(
                  controller: name,
                  placeholder: 'Enter item name',
                  style: TextStyle(color: Colors.white),
                  // You can add controllers, validators, etc., based on your needs
                ),
              ),
            ],
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: CupertinoTextField(
                  controller: description,
                  placeholder: 'Enter item Description',
                  style: TextStyle(color: Colors.white),
                  // You can add controllers, validators, etc., based on your needs
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Obx(
              () => Text(controller.isLoading6.value ? "Loading" : 'Save')),
          onPressed: () {
            // Handle save action
            if (name.text == "" || description.text == "") {
              Get.showSnackbar(
                GetSnackBar(
                  titleText: Text("Failed"),
                  messageText: Text("Please fill your name and description"),
                  backgroundColor: Colors.black38,
                  duration: const Duration(milliseconds: 1300),
                  snackPosition: SnackPosition.TOP,
                  barBlur: 5,
                ),
              );
            } else {
              controller.updateTodo(
                  widget.data.id, name.text, description.text, context);
            }
          },
        ),
      ],
    );
  }
}
