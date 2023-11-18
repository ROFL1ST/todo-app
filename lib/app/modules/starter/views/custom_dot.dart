import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const CustomDotIndicator({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.all(5),
          height: 10,
          width:  40,
          decoration: BoxDecoration(
            color: index == currentIndex ? Color(0xFFD9D9D9) : Color(0xFFD9D9D9).withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }).expand((widget) => [widget, SizedBox(width: 10.0)]).toList(),
    );
  }
}
