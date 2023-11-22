import 'package:chat_rooms/core/services/injection_container.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/auth/authentication_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:chat_rooms/src/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/crud_rooms/crud_rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/rooms/rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/topics/topics_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/update/update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> appProviders(BuildContext context) => [
      BlocProvider(
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
      ),
    ];
