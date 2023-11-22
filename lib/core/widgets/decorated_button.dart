import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class DecoratedButton extends StatelessWidget {
  final void Function()? action;
  final bool? isCreatedRoom;
  final String? text;
  final Color? color;
  final IconData? icon;

  const DecoratedButton({
    Key? key,
    this.action,
    this.isCreatedRoom = false,
    this.text,
    this.color = oceanColor,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getWidth(double width) {
      return ResponsiveLayout.getWidth(width, context);
    }

    double getHeight(double height) {
      return ResponsiveLayout.getHeight(height, context);
    }

    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color!,
        disabledBackgroundColor: color!.withOpacity(.5),
        shape: icon == null ?  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getWidth(5)),
        ): const CircleBorder(),
      ),
      onPressed: action,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getHeight(10)),
        child: isCreatedRoom!
            ? Row(
                children: [
                  Icon(
                    Icons.add,
                    color: bgColor,
                    size: getWidth(20),
                  ),
                  SizedBox(width: getWidth(5)),
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: getFontSize(9),
                      color: bgColor,
                    ),
                  ),
                ],
              )
            : icon == null ? Text(
                text!,
                style: TextStyle(
                  fontSize: getFontSize(9),
                  color: bgColor,
                ),
              ) : Icon(icon, size: getWidth(30), color: oceanColor,),
      ),
    );
  }
}
