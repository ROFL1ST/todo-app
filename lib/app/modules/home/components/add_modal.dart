// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:todo_app/config/common.dart';

class AddModal extends StatefulWidget {
  const AddModal({super.key});

  @override
  State<AddModal> createState() => _AddModalState();
}

class _AddModalState extends State<AddModal> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          color: kBackgroundColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Activity", style: kTextAppBarDark),
                      ],
                    ),
                  ),
                  Divider(
                    color: kCardColor,
                    thickness: 0.2,
                  ),
                  SizedBox(
                    child: TextField(
                      controller: controller.name,
                      cursorColor: kTextColor,
                      decoration: InputDecoration(
                        hintText: "New Activity",
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kCardColor,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kCardColor,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: kTextLightColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.height * 0.02,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  const Divider(
                    color: kCardColor,
                    thickness: 0.2,
                  ),
                  SizedBox(
                    child: TextField(
                      controller: controller.description,
                      cursorColor: kTextColor,
                      decoration: InputDecoration(
                        hintText: "Description",
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kCardColor,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kCardColor,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: kTextLightColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.height * 0.02,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: kCardColor,
                    thickness: 0.2,
                  ),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Nope",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.addTodo(context);
                              if (controller.isLoading3.value == false) {
                                // Navigator.pop(context);
                              }
                            },
                            child: Text(
                              controller.isLoading3.value
                                  ? "Loading..."
                                  : "Submit",
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
