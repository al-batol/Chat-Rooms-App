import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsUserSignedInScreen extends StatelessWidget {
  static const String routeName = 'main-screen';

  const IsUserSignedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, usersState) {
        if (usersState is LoadUsers) {
          return StreamBuilder(
              stream: usersState.users,
              builder: (context, usersSnapshot) {
                return StreamBuilder(
                    stream: usersState.userChanges,
                    builder: (context, snapshot) {
                      final userData = snapshot.data;
                      if (userData != null) {
                        return HomeScreen(
                          isUserSignedIn: true,
                          isUserVerified: userData.emailVerified,
                          users: usersSnapshot.data,
                        );
                      } else {
                        return HomeScreen(
                          isUserSignedIn: false,
                          users: usersSnapshot.data,
                        );
                      }
                    });
              });
        } else {
          // FlutterNativeSplash.remove();
          return const Scaffold(backgroundColor: bgColor,);
        }
      },
    );
  }
}
