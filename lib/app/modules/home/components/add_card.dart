// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/config/common.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: kBackgroundColor,
        color: kCardColor,
        child: Container(
          width: constraints.maxWidth / 2 - 10,
          height: Get.height * 0.18,
          child: Center(
            child: IconButton(icon: Icon(Iconsax.add), onPressed: () {}),
          ),
        ),
      );
    });
  }
}
