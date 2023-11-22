import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class DecoratedChip extends StatelessWidget {
  final String label;

  const DecoratedChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = ResponsiveLayout.screenWidth(context);

    double getHeight(double height) {
      return ResponsiveLayout.getHeight(height, context);
    }

    double getWidth(double width) {
      return ResponsiveLayout.getWidth(width, context);
    }

    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
    }

    return Container(
      width: w * .35,
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(10),
        vertical: getHeight(10),
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(getWidth(20)),
        border: Border.all(
          color: oceanColor,
          width: getWidth(2),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: oceanColor,
          fontSize: getFontSize(9),
        ),
      ),
    );
  }
}
