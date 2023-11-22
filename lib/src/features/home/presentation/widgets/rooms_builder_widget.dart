part of 'package:chat_rooms/src/features/home/presentation/screens/home_screen.dart';

class RoomsBuilderWidget extends StatelessWidget {
  final List<User>? users;
  final bool isUserSignedIn;
  final String? userId;
  final String? hostPhoto;
  final List<Room> rooms;
  final List<Topic> topics;

  const RoomsBuilderWidget({
    Key? key,
    this.users,
    required this.isUserSignedIn,
    this.userId,
    this.hostPhoto,
    required this.rooms,
    required this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getHeight(double height) {
      return ResponsiveLayout.getHeight(height, context);
    }

    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return SizedBox(height: getHeight(10));
        },
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final roomData = rooms[index];
          String? topic;
          if (topics.isNotEmpty) {
            topic = topics[topics
                    .indexWhere((topic) => topic.topicId == roomData.topicId)]
                .topic;
          }
          String? displayName = 'empty';
          String? hostAvatar;
          List<String> participantsPhotos = [];
          if (users != null) {
            final User user = users![
                users!.indexWhere((user) => user.userId == roomData.hostId)];
            hostAvatar = user.avatar;
            displayName = user.name;
            final int totalParticipants = roomData.participants!.length;
            for (int participant = 0;
                participant <
                    (totalParticipants >= 10 ? 10 : totalParticipants);
                participant++) {
              if(users != null) {
                participantsPhotos.add(users![users!.indexWhere((user) =>
                user.userId == roomData.participants![participant])]
                    .avatar!);
              }
            }
          }
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ChatScreen.routeName, arguments: {
                'roomId': roomData.roomId,
                'hostId': roomData.hostId,
                'userId': userId,
                'roomName': roomData.name,
                'description': roomData.description,
                'isUserSignedIn': isUserSignedIn,
                'users': users,
                'topic': topic,
                'topicId': roomData.topicId,
              });
            },
            child: RoomCard(
              displayName: displayName!,
              date: Jiffy.parseFromDateTime(DateTime.parse(roomData.created!))
                  .fromNow()
                  .toString(),
              roomName: roomData.name!,
              participantsPhotos: participantsPhotos,
              totalParticipates: roomData.participants!.length.toString(),
              topic: topic ?? '',
              hostPhoto: hostAvatar,
            ),
          );
        });
  }
}
