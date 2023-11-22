import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/core/widgets/photo_card.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String displayName;
  final String? hostPhoto;
  final String date;
  final String roomName;
  final List<String> participantsPhotos;
  final String totalParticipates;
  final String topic;

  const RoomCard({
    Key? key,
    required this.displayName,
    required this.date,
    required this.roomName,
    required this.participantsPhotos,
    required this.totalParticipates,
    required this.topic,
    this.hostPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      padding: EdgeInsets.all(getWidth(18)),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  PhotoCard(
                    size: getWidth(25),
                    photo: hostPhoto,
                  ),
                  SizedBox(width: getWidth(5)),
                  Text(
                    displayName,
                    style: TextStyle(
                      fontSize: getFontSize(9),
                      color: oceanColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: getFontSize(9),
                  color: darkWhiteFontColor,
                ),
              ),
            ],
          ),
          SizedBox(height: getHeight(10)),
          Text(
            roomName,
            style: TextStyle(
              color: whiteFontColor,
              fontSize: getFontSize(11),
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: getHeight(15)),
          Row(
            children: [
              if (participantsPhotos.isNotEmpty)
                ...List.generate(
                  participantsPhotos.length,
                  (i) => Padding(
                    padding: EdgeInsets.only(right: getWidth(10)),
                    child: PhotoCard(
                      size: getWidth(25),
                      photo: participantsPhotos[i],
                    ),
                  ),
                ).toList()
              // else
              //   // this is to make the card
              //   // remains as it's size
              //   Visibility(
              //     visible: false,
              //     maintainState: true,
              //     maintainInteractivity: true,
              //     maintainAnimation: true,
              //     maintainSize: true,
              //     child: PhotoCard(
              //       size: getWidth(25),
              //     ),
              //   ),
            ],
          ),
          SizedBox(height: getHeight(25)),
          const Divider(
            color: lightFontColor,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.group_outlined,
                    color: oceanColor,
                    size: getWidth(20),
                  ),
                  SizedBox(width: getWidth(5)),
                  Text(
                    totalParticipates,
                    style: TextStyle(
                        color: darkWhiteFontColor, fontSize: getFontSize(8)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(getWidth(7)),
                decoration: BoxDecoration(
                    color: searchColor,
                    borderRadius: BorderRadius.circular(getWidth(15))),
                child: Text(
                  topic,
                  style: TextStyle(
                      color: darkWhiteFontColor, fontSize: getFontSize(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
