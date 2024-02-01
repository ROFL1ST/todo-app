import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/app/modules/home/views/home_view.dart';
import 'package:todo_app/app/modules/profile/views/profile_view.dart';
import 'package:todo_app/config/common.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  final controller = Get.put(BottomBarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final global = Get.put(GlobalController());
    return GetBuilder<BottomBarController>(builder: (control) {
      return Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              HomeView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: kBackgroundColor),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: GNav(
            rippleColor:
                Colors.grey[800]!, // tab button ripple color when pressed
            hoverColor: Colors.grey[700]!, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            // tab button shadow
            // curve: Curves.easeIn, // tab animation curves
            duration: Duration(milliseconds: 900), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: kButtonColor, // selected icon and text color
            iconSize: 24, // tab button icon size

            tabBackgroundColor:
                kButtonColor.withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            tabs: [
              GButton(
                icon: controller.tabIndex.value == 0
                    ? IconlyBold.home
                    : IconlyLight.home,
                text: "Home",
              ),
              GButton(
                icon: controller.tabIndex.value == 1
                    ? IconlyBold.search
                    : IconlyLight.search,
                text: "Search",
              ),
              GButton(
                icon: controller.tabIndex.value == 2
                    ? IconlyBold.notification
                    : IconlyLight.notification,
                text: "Notification",
                leading: controller.notifs.value.length != 0
                    ? Stack(
                        children: [
                          Icon(
                            controller.tabIndex.value == 2
                                ? IconlyBold.notification
                                : IconlyLight.notification,
                            color: Colors.white,
                          ),
                          Positioned(
                            top: -5,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red, // or your preferred color
                              ),
                              child: Text(
                                controller.notifs.value.length.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              GButton(
                icon: controller.tabIndex.value == 3
                    ? IconlyBold.profile
                    : IconlyLight.profile,
                text: "Profile",
              )
            ],
            selectedIndex: controller.tabIndex.value,
            onTabChange: (index) {
              setState(() {
                controller.tabIndex.value = index;
              });
            },
          ),
        ),
      );
    });
  }
}
