import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/core/utils/show_proccess_indicator.dart';
import 'package:chat_rooms/core/utils/show_snack_bar.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:chat_rooms/core/widgets/decorated_button.dart';
import 'package:chat_rooms/core/widgets/decorated_text_field.dart';
import 'package:chat_rooms/src/features/chats/presentation/widgets/message_widget.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/crud_rooms/crud_rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/screens/create_new_room.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';
  final String roomId;
  final String? hostId;
  final String? userId;
  final String roomName;
  final String roomDescription;
  final bool isUserSignedIn;
  final List<User> users;
  final String topic;
  final String topicId;

  const ChatScreen({
    Key? key,
    required this.roomId,
    required this.hostId,
    required this.userId,
    required this.isUserSignedIn,
    required this.roomName,
    required this.roomDescription,
    required this.users,
    required this.topic,
    required this.topicId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController messagesController = ScrollController();
  final TextEditingController messageCtr = TextEditingController();

  bool isAdmin() {
    if (widget.userId != null && widget.hostId != null) {
      return widget.userId == widget.hostId;
    }
    return false;
  }

  @override
  void dispose() {
    messagesController.dispose();
    messageCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ChatsBloc>().add(GetAllMessagesEvent(widget.roomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double w = ResponsiveLayout.screenWidth(context);
    final double h = ResponsiveLayout.screenHeight(context);

    double getHeight(double height) {
      return ResponsiveLayout.getHeight(height, context);
    }

    double getWidth(double width) {
      return ResponsiveLayout.getWidth(width, context);
    }

    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
    }

    void pop() {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: oceanColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (isAdmin()) ...[
            IconButton(
              onPressed: () async {
                await context
                    .read<CrudRoomsCubit>()
                    .deleteRoom(roomId: widget.roomId);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateNewRoomScreen.routeName,
                    arguments: {
                      'roomId': widget.roomId,
                      'name': widget.roomName,
                      'description': widget.roomDescription,
                      'topic': widget.topic,
                      'topicId': widget.topicId,
                    });
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ]
        ],
        title: Text(
          widget.roomName,
          style: TextStyle(
            color: darkWhiteFontColor,
            fontSize: getFontSize(13.5),
          ),
        ),
      ),
      body: BlocListener<CrudRoomsCubit, CrudRoomsState>(
        listener: (context, state) {
          if (state is DeletingRoom) {
            showProcessIndicator(context);
          } else if (state is RoomDeleted) {
            context.read<SettingsCubit>().removeRoomFromState(state.roomId);
            showSnackBar(context, state.message, true);
            pop();
          } else if (state is RoomsError) {
            showSnackBar(context, state.message, false);
          }
        },
        child: BlocBuilder<ChatsBloc, ChatsState>(
          builder: (context, state) {
            return state is LoadedMessages
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                          controller: messagesController,
                          children: [
                            Container(
                              padding: EdgeInsets.all(getWidth(10)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: getWidth(40),
                                  vertical: getWidth(20)),
                              decoration: BoxDecoration(
                                color: searchColor.withOpacity(.6),
                                borderRadius:
                                    BorderRadius.circular(getWidth(10)),
                              ),
                              child: Text(
                                widget.roomDescription,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getFontSize(12),
                                ),
                              ),
                            ),
                            StreamBuilder(
                                stream: state.messages,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      messagesController.animateTo(
                                        messagesController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                      );
                                    });
                                    return ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.all(getHeight(10)),
                                        separatorBuilder: (context, index) {
                                          return SizedBox(height: getHeight(5));
                                        },
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          final message = snapshot.data![index];
                                          final bool amISender =
                                              widget.userId == message.userId!;
                                          final User userData = widget.users[
                                              widget.users.indexWhere((user) =>
                                                  user.userId ==
                                                  message.userId)];
                                          return Align(
                                            alignment: amISender
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: w * .8,
                                              ),
                                              padding: amISender
                                                  ? EdgeInsets.only(
                                                      right: getWidth(10))
                                                  : EdgeInsets.only(
                                                      left: getWidth(10)),
                                              margin: EdgeInsets.only(
                                                  top: getWidth(10)),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                left: !amISender
                                                    ? BorderSide(
                                                        color: searchColor,
                                                        width: getWidth(2))
                                                    : const BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 0),
                                                right: amISender
                                                    ? BorderSide(
                                                        color: searchColor,
                                                        width: getWidth(2))
                                                    : const BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 0),
                                              )),
                                              child: MessageWidget(
                                                photoSize: getWidth(25),
                                                username: userData.name!,
                                                avatar: userData.avatar,
                                                fontSize: getFontSize(9),
                                                amISender: amISender,
                                                message: message.body!,
                                                timeSent: message.created!,
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                }),
                          ],
                        ),
                      ),
                      Container(
                        color: searchColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: DecoratedTextField(
                                hintText: widget.isUserSignedIn
                                    ? 'type your message'
                                    : 'Please Login or create a new account ',
                                controller: messageCtr,
                                isDisables: widget.isUserSignedIn,
                              ),
                            ),
                            if (widget.isUserSignedIn)
                              DecoratedButton(
                                color: searchColor,
                                action: widget.userId != null
                                    ? () {
                                        if (widget.userId != null) {
                                          context.read<ChatsBloc>().add(
                                                CreateNewMessageEvent(
                                                  messageCtr.text.trim(),
                                                  widget.roomId,
                                                  widget.hostId!,
                                                ),
                                              );
                                          messageCtr.clear();
                                        }
                                      }
                                    : null,
                                icon: Icons.send,
                              ),
                          ],
                        ),
                      )
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
