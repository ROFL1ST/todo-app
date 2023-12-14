// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/app/helper/hero_dialogue_route.dart';
import 'package:todo_app/app/modules/home/components/add_modal.dart';
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
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return AddModal();
            }));
          },
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            height: Get.height * 0.18,
            child: Center(child: Icon(Iconsax.add)),
          ),
        ),
      );
    });
  }
}
