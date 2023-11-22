import 'package:chat_rooms/core/utils/app_strings.dart';
import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:chat_rooms/src/features/chats/presentation/screens/chat_screen.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/rooms/rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/topics/topics_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/screens/create_new_room.dart';
import 'package:chat_rooms/src/features/home/presentation/widgets/decorated_chip.dart';
import 'package:chat_rooms/core/widgets/decorated_text_field.dart';
import 'package:chat_rooms/src/features/home/presentation/widgets/homeAppBar.dart';
import 'package:chat_rooms/src/features/home/presentation/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


part 'package:chat_rooms/src/features/home/presentation/widgets/rooms_builder_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String homeScreenRoute = '/home-screen';
  final bool isUserSignedIn;
  final bool? isUserVerified;

  final List<User>? users;

  HomeScreen({
    Key? key,
    required this.isUserSignedIn,
    this.isUserVerified = false,
    required this.users,
  }) : super(key: key);
  TextEditingController searchCtr = TextEditingController();

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

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<UserAuthCubit, UserAuthState>(
            builder: (context, state) {
              User? user;
              if (state.userState == UserStates.userData) {
                user = state.user;
                return Column(
                  children: [
                    HomeAppBar(
                      userId: user?.userId,
                      isUserSignedIn: isUserSignedIn,
                      hostUserName: user?.name,
                      hostPhoto: user?.avatar,
                      users: users,
                    ),
                    if (isUserSignedIn && !isUserVerified!)
                      Container(
                        width: w,
                        height: h * .05,
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.verifyingMessage!,
                              style: const TextStyle(),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<UserAuthCubit>()
                                    .sendEmailVerification();
                              },
                              child: Center(
                                  child: Text(state.verifyingTextButton!)),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: getHeight(25)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getHeight(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedTextField(
                            hintText: 'search for rooms',
                            hasSearchIcon: true,
                            controller: searchCtr,
                            onChange: context.read<RoomsCubit>().searchByName,
                          ),
                          SizedBox(height: getHeight(25)),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: getWidth(25)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DecoratedChip(label: 'Browse Topics'),
                                DecoratedChip(label: 'Recent Activities'),
                              ],
                            ),
                          ),
                          SizedBox(height: getHeight(25)),
                          BlocBuilder<TopicsCubit, TopicsState>(
                              builder: (context, state) {
                            if (state is LoadedTopics) {
                              FlutterNativeSplash.remove();

                              return StreamBuilder(
                                  stream: state.allTopics,
                                  builder: (context, topicsSnapshot) {
                                    if (topicsSnapshot.hasData) {
                                      return BlocBuilder<RoomsCubit,
                                          RoomsState>(
                                        builder: (context, state) {
                                          if (state is LoadedRooms) {
                                            return StreamBuilder(
                                                stream: state.allRooms,
                                                builder:
                                                    (context, roomsSnapshot) {
                                                  if (roomsSnapshot.hasData) {
                                                    final String roomsNumber =
                                                        roomsSnapshot.data ==
                                                                null
                                                            ? '0'
                                                            : roomsSnapshot
                                                                .data!.length
                                                                .toString();
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Rooms',
                                                          style: TextStyle(
                                                              color:
                                                                  whiteFontColor,
                                                              fontSize:
                                                                  getFontSize(
                                                                      12),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                getHeight(5)),
                                                        Text(
                                                          '$roomsNumber Rooms available',
                                                          style: TextStyle(
                                                              color:
                                                                  darkWhiteFontColor,
                                                              fontSize:
                                                                  getFontSize(
                                                                      9),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                getHeight(10)),
                                                        Text(
                                                          'All Rooms',
                                                          style: TextStyle(
                                                            color: oceanColor,
                                                            fontSize:
                                                                getFontSize(9),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        if (roomsSnapshot
                                                            .data!.isNotEmpty)
                                                          RoomsBuilderWidget(
                                                            isUserSignedIn:
                                                                isUserSignedIn,
                                                            rooms: roomsSnapshot
                                                                .data!,
                                                            topics:
                                                                topicsSnapshot
                                                                    .data!,
                                                            userId:
                                                                user?.userId,
                                                            hostPhoto:
                                                                user?.avatar,
                                                            users: users,
                                                          )
                                                        else
                                                          Center(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: getHeight(
                                                                          150)),
                                                              child: const Text(
                                                                'There aren\'t rooms at the moment ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    );
                                                  } else {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                });
                                          } else if (state is SearchResult) {
                                            return RoomsBuilderWidget(
                                              isUserSignedIn: isUserSignedIn,
                                              rooms: state.foundRooms,
                                              topics: topicsSnapshot.data!,
                                              userId: user?.userId,
                                              hostPhoto: user?.avatar,
                                              users: users,
                                            );
                                          } else if (state is RoomsError) {
                                            return Text(state.message);
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: oceanColor,
        child: const Icon(Icons.add),
        onPressed: () {
          if (isUserSignedIn) {
            Navigator.of(context)
                .pushNamed(CreateNewRoomScreen.routeName, arguments: {
              'isUserVerified': isUserVerified,
            });
          } else {
            Navigator.of(context).pushNamed(SignInScreen.routeName);
          }
        },
      ),
    );
  }
}
