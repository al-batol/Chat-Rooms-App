import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/widgets/photo_card.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MessageWidget extends StatelessWidget {
  final double photoSize;
  final double fontSize;
  final String? avatar;
  final String username;
  final bool amISender;
  final String message;
  final String timeSent;

  const MessageWidget(
      {Key? key,
      required this.photoSize,
      this.avatar,
      required this.username,
      required this.fontSize,
      required this.amISender,
      required this.message,
      required this.timeSent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          amISender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Directionality(
            textDirection: amISender ? TextDirection.rtl : TextDirection.ltr,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  amISender ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Flexible(
                  child: PhotoCard(
                    size: photoSize,
                    photo: avatar,
                  ),
                ),
                SizedBox(width: photoSize / 2.5),
                Flexible(
                  child: Text(
                    username,
                    style: TextStyle(
                      color: oceanColor,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                SizedBox(width: photoSize / 2.5),
                Flexible(
                  child: Text(
                    Jiffy.parse(timeSent).format(pattern: 'h:mm a').toString(),
                    style: TextStyle(
                      color: lightFontColor,
                      fontSize: fontSize,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: photoSize / 2.5),
        Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize + 3,
          ),
        ),
      ],
    );
  }
}
