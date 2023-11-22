import 'package:chat_rooms/core/is_user_signed_in.dart';
import 'package:chat_rooms/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:chat_rooms/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:chat_rooms/src/features/chats/presentation/screens/chat_screen.dart';
import 'package:chat_rooms/src/features/home/presentation/screens/create_new_room.dart';
import 'package:chat_rooms/src/features/settings/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter();

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case IsUserSignedInScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => const IsUserSignedInScreen());
      case SignupScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignInScreen());
      case CreateNewRoomScreen.routeName:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (BuildContext context) => CreateNewRoomScreen(
            isUserVerified: arguments?['isUserVerified'],
            roomId: arguments?['roomId'],
            name: arguments?['name'],
            description: arguments?['description'],
            topic: arguments?['topic'],
            topicId: arguments?['topicId'],
          ),
        );
      case ChatScreen.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (BuildContext context) => ChatScreen(
            roomId: arguments['roomId'],
            hostId: arguments['hostId'],
            userId: arguments['userId'],
            isUserSignedIn: arguments['isUserSignedIn'],
            roomName: arguments['roomName'],
            roomDescription: arguments['description'],
            users: arguments['users'],
            topic: arguments['topic'],
            topicId: arguments['topicId'],
          ),
        );
      case ProfileScreen.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            userId: arguments['userId'],
            users: arguments['users'],
          ),
        );
    }
    return null;
  }
}
