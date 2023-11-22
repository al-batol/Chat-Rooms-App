import 'package:chat_rooms/core/helper/app_router.dart';
import 'package:chat_rooms/core/helper/providers.dart';
import 'package:chat_rooms/core/services/injection_container.dart';
import 'package:chat_rooms/core/is_user_signed_in.dart';
import 'package:chat_rooms/firebase_options.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/auth/authentication_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:chat_rooms/src/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/crud_rooms/crud_rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/rooms/rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/topics/topics_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/update/update_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) async => await init());
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:     [BlocProvider(
        create: (context) => sl<UserAuthCubit>()..getUserData(),
      ),
        BlocProvider(
          create: (context) => sl<UsersCubit>()..getAllUsers(),
        ),
        BlocProvider(
          create: (context) => sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<TopicsCubit>()..getAllTopics(),
        ),
        BlocProvider(
          create: (context) => sl<RoomsCubit>()..getAllRooms(),
        ),
        BlocProvider(
          create: (context) => sl<CrudRoomsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ChatsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SettingsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateCubit>(),
        )],
      child: MaterialApp(
        title: 'Rooms Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const IsUserSignedInScreen(),
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      ),
    );
  }
}
