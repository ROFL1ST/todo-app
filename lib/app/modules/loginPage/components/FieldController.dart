import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/common.dart';

class FieldController extends StatelessWidget {
  final Widget child;
  const FieldController({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: kBgForm,
        borderRadius: BorderRadius.circular(9),
      ),
      child: child,
    );
  }
}
