import 'dart:developer';

import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/core/utils/assets_strings.dart';
import 'package:chat_rooms/core/widgets/photo_card.dart';
import 'package:chat_rooms/core/utils/show_proccess_indicator.dart';
import 'package:chat_rooms/core/utils/user_auth.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:chat_rooms/src/features/home/presentation/widgets/menu_item.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/update/update_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  final String? userId;
  final bool isUserSignedIn;
  final String? hostUserName;
  final String? hostPhoto;
  final List<User>? users;

  const HomeAppBar({
    Key? key,
    this.userId,
    required this.isUserSignedIn,
    this.hostUserName,
    this.hostPhoto,
    this.users,
  }) : super(key: key);

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

    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.userProfileState == UserProfileState.signingOut) {
          showProcessIndicator(context);
        } else if (state.userProfileState == UserProfileState.signedOut) {
          context.read<UserAuthCubit>().getUserData(user: const User());
          Navigator.pop(context);
        }
      },
      child: Container(
        color: secondaryColor,
        height: getHeight(60),
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(20),
        ),
        child: BlocBuilder<UpdateCubit, UpdateState>(
          builder: (context, state) {
            String? name;
            String? photo;
            if (state is UserProfileUpdated) {
              name = state.userName;
              photo = state.photoUrl;
            } else if (state is AvatarUploaded) {
              name = state.userName;
              photo = state.photoUrl;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PhotoCard(
                  size: getWidth(30),
                  hasBorder: false,
                  svgName: logoSvg,
                ),
                GestureDetector(
                  onTap: () {
                    if (isUserSignedIn) {
                      Navigator.pushNamed(context, ProfileScreen.routeName,
                          arguments: {
                            'userId': userId,
                            'users': users,
                          });
                    } else {
                      Navigator.of(context).pushNamed(SignInScreen.routeName);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PhotoCard(
                        size: getWidth(35),
                        photo: photo ?? hostPhoto,
                        hasBorder: isUserSignedIn ? true : false,
                      ),
                      SizedBox(
                        width: getWidth(10),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: w * .25,
                        ),
                        child: Text(
                          hostUserName != null
                              ? name ?? hostUserName!
                              : 'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: lightFontColor,
                            fontSize: getFontSize(10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (isUserSignedIn)
                        RotatedBox(
                          quarterTurns: 3,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                dividerTheme: const DividerThemeData(
                                    color: bgColor, thickness: 1)),
                            child: PopupMenuButton(
                              padding: EdgeInsets.zero,
                              color: const Color(0xFF696D97),
                              offset: const Offset(-50, -20),
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<dynamic>>[
                                PopupMenuItem(
                                  child: const MenuItem(
                                    text: "Settings",
                                    icon: Icons.build_outlined,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ProfileScreen.routeName,
                                        arguments: {
                                          'userId': userId,
                                          'users': users,
                                        });
                                  },
                                ),
                                const PopupMenuDivider(),
                                PopupMenuItem(
                                  onTap: () {
                                    context.read<SettingsCubit>().signOut();
                                  },
                                  child: const MenuItem(
                                    text: "Log out",
                                    icon: Icons.login_outlined,
                                  ),
                                ),
                              ],
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: oceanColor,
                                size: getWidth(20),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
