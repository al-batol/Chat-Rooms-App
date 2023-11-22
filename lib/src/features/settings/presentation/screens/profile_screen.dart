import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/core/widgets/photo_card.dart';
import 'package:chat_rooms/core/widgets/decorated_button.dart';
import 'package:chat_rooms/core/widgets/decorated_text_field.dart';
import 'package:chat_rooms/core/utils/show_proccess_indicator.dart';
import 'package:chat_rooms/core/utils/show_snack_bar.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/home/data/models/topic_model.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/topics/topics_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/screens/home_screen.dart';
import 'package:chat_rooms/src/features/home/presentation/widgets/room_card.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/update/update_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  final List<User>? users;
  static const String routeName = '/profile';

  const ProfileScreen({Key? key, required this.userId, this.users})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController bioCtr = TextEditingController();

  void getUserProfile() async {
    await context.read<SettingsCubit>().getUserProfile(widget.userId);
    if (context.mounted) {
      final userProfile = context.read<SettingsCubit>().state.userProfile;
      nameCtr.text = userProfile!.name!;
      bioCtr.text = userProfile.bio!;
    }
    if (context.mounted) {
      await context.read<SettingsCubit>().getMyRooms(widget.userId);
    }
    if (context.mounted) {
      await context.read<SettingsCubit>().getTopics();
    }
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  void dispose() {
    nameCtr.dispose();
    bioCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double getHeight(double height) {
      return ResponsiveLayout.getHeight(height, context);
    }

    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
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
        title: Text(
          'Edit Your Profile',
          style: TextStyle(
            color: darkWhiteFontColor,
            fontSize: getFontSize(13.5),
          ),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.userProfileState == UserProfileState.loaded) {
            return BlocListener<UpdateCubit, UpdateState>(
              listener: (context, state) {
                if (state is UpdatingUserProfile) {
                  showProcessIndicator(context);
                } else if (state is UserProfileUpdated) {
                  showSnackBar(context, state.message, true);
                  Navigator.pop(context);
                } else if (state is UploadingProfileError) {
                  showSnackBar(context, state.message, false);
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: getHeight(15)),
                margin: EdgeInsets.only(top: getHeight(15)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfilePhoto(
                        userId: widget.userId,
                        photoUrl: state.userProfile!.avatar!,
                        photoSize: getHeight(120),
                        photoPickerSize: getHeight(40),
                      ),
                      SizedBox(height: getHeight(20)),
                      DecoratedTextField(
                        hintText: 'name',
                        controller: nameCtr,
                      ),
                      SizedBox(height: getHeight(20)),
                      DecoratedTextField(
                        height: getHeight(200),
                        hintText: 'bio',
                        controller: bioCtr,
                        hasMultiLines: true,
                      ),
                      SizedBox(height: getHeight(25)),
                      DecoratedButton(
                        action: () async {
                          await context.read<UpdateCubit>().updateUserProfile(
                                context: context,
                                userId: widget.userId,
                                bio: bioCtr.text.trim(),
                                name: nameCtr.text.trim(),
                              );
                        },
                        text: 'Update',
                      ),
                      SizedBox(height: getHeight(25)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'My Rooms',
                          style: TextStyle(
                              color: whiteFontColor,
                              fontSize: getFontSize(12),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: getHeight(20)),
                      if (state.roomsAndTopicsState ==
                          RoomsAndTopicsState.loaded)
                        if (state.myRooms!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(bottom: getHeight(20)),
                            child: RoomsBuilderWidget(
                              users: widget.users,
                              userId: widget.userId,
                              hostPhoto: state.userProfile!.avatar!,
                              isUserSignedIn: true,
                              rooms: state.myRooms!,
                              topics: state.topics!,
                            ),
                          )
                        else
                          const Text(
                            'You don\'t have any room',
                            style: TextStyle(color: Colors.white),
                          )
                      else if (state.roomsAndTopicsState ==
                          RoomsAndTopicsState.loading)
                        Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
