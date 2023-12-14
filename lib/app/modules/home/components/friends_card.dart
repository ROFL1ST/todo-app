// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/app/data/model/friends.dart' as Friends;
import 'package:todo_app/config/common.dart';

class FriendCard extends StatefulWidget {
  const FriendCard({
    super.key,
    required this.friendList,
    required this.index,
  });

  final RxList<Friends.Datum> friendList;
  final int index;

  @override
  State<FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Card left
          Row(
            children: [
              widget.friendList[widget.index].photoProfile != null &&
                      widget.friendList[widget.index].photoProfile != ""
                  ? CircleAvatar(
                      radius: Get.width * 0.055,
                      backgroundImage: CachedNetworkImageProvider(
                          widget.friendList[widget.index].photoProfile,
                          cacheKey:
                              widget.friendList[widget.index].photoProfile),
                    )
                  : Initicon(
                      text: widget.friendList[widget.index].name,
                      size: Get.width * 0.095,
                      backgroundColor: Color(int.parse(
                              widget.friendList[widget.index].defaultColor
                                  .substring(1, 7),
                              radix: 16) +
                          0xFF000000),
                    ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              Container(
                width: Get.width * 0.2,
                child: AutoSizeText(
                  widget.friendList[widget.index].username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  presetFontSizes: [16, 14],
                  // stepGranularity: 10,
                ),
              )
            ],
          ),
          // Card left
          Container(
            decoration: BoxDecoration(
                color: kColor1, borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text("Invite"),
            )),
          ),
        ],
      ),
    );
  }
}
