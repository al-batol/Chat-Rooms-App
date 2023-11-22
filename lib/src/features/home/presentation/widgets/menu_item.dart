import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const MenuItem({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getWidth(double width) {
      return ResponsiveLayout.getWidth(width, context);
    }

    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: getWidth(20),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: getFontSize(11)),
        ),
      ],
    );
  }
}
