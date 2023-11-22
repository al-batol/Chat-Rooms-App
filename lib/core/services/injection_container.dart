import 'package:chat_rooms/core/utils/upload_photo.dart';
import 'package:chat_rooms/src/features/auth/data/date_source/auth_remote_date_source.dart';
import 'package:chat_rooms/src/features/auth/data/repository/auth_repo_imp.dart';
import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/create_user_with_email_and_password.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/get_all_users.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/get_user_changes.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/set_user_data.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/sing_in_with_google.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/auth/authentication_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:chat_rooms/src/features/chats/data/data_sources/chat_remote_data_source.dart';
import 'package:chat_rooms/src/features/chats/data/repositories/chats_repository_imp.dart';
import 'package:chat_rooms/src/features/chats/domain/repositories/chats_repository.dart';
import 'package:chat_rooms/src/features/chats/domain/usecases/create_new_message.dart';
import 'package:chat_rooms/src/features/chats/domain/usecases/get_all_messages.dart';
import 'package:chat_rooms/src/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:chat_rooms/src/features/home/data/data_source/home_remote_data_source.dart';
import 'package:chat_rooms/src/features/home/data/repository/home_repository_imp.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/create_new_room.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/create_new_topic.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/delete_room.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/get_all_rooms.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/get_all_topics.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/search_by_name.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/update_room.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/crud_rooms/crud_rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/rooms/rooms_cubit.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/topics/topics_cubit.dart';
import 'package:chat_rooms/src/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:chat_rooms/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:chat_rooms/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/get_my_rooms.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/get_topics.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/get_user_profile.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/sign_out.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/update_user_profile.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/update/update_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(
      () => UsersCubit(
        getAllUsers: sl(),
        auth: sl(),
      ),
    )
    ..registerFactory(() => AuthenticationCubit(
          createUser: sl(),
          setUserData: sl(),
          uploadPhoto: sl(),
          signInWithEmailAndPassword: sl(),
          getUserChanges: sl(),
          signInWithGoogle: sl(),
        ))
    ..registerFactory(() => RoomsCubit(
          getAllRooms: sl(),
          searchByName: sl(),
        ))
    ..registerFactory(
      () => TopicsCubit(getAllTopics: sl()),
    )
    ..registerFactory(
      () => CrudRoomsCubit(
        createNewRoom: sl(),
        createNewTopic: sl(),
        updateRoom: sl(),
        deleteRoom: sl(),
      ),
    )
    ..registerFactory(
      () => ChatsBloc(
        getAllMessages: sl(),
        createNewMessage: sl(),
      ),
    )
    ..registerFactory(
      () => UserAuthCubit(),
    )
    ..registerFactory(
      () => SettingsCubit(
          signOut: sl(),
          getUserProfile: sl(),
          updateUserProfile: sl(),
          getMyRooms: sl(),
          getTopics: sl()),
    )
    ..registerFactory(() => UpdateCubit(
          updateUserProfile: sl(),
        ))
    // Use cases
    ..registerLazySingleton(() => GetAllUsers(sl()))
    ..registerLazySingleton(() => CreateUserWithEmailAndPassword(sl()))
    ..registerLazySingleton(() => SignInWithGoogle(sl()))
    ..registerLazySingleton(() => SetUserData(sl()))
    ..registerLazySingleton(() => SignInWithEmailAndPassword(sl()))
    ..registerLazySingleton(() => GetUserChanges(sl()))
    ..registerLazySingleton(() => GetAllRooms(sl()))
    ..registerLazySingleton(() => CreateNewRoom(sl()))
    ..registerLazySingleton(() => GetAllMessages(sl()))
    ..registerLazySingleton(() => CreateNewMessage(sl()))
    ..registerLazySingleton(() => GetAllTopics(sl()))
    ..registerLazySingleton(() => CreateNewTopic(sl()))
    ..registerLazySingleton(() => SearchByName(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => GetUserProfile(sl()))
    ..registerLazySingleton(() => UpdateUserProfile(sl()))
    ..registerLazySingleton(() => GetMyRooms(sl()))
    ..registerLazySingleton(() => GetTopics(sl()))
    ..registerLazySingleton(() => DeleteRoom(sl()))
    ..registerLazySingleton(() => UpdateRoom(sl()))
    // Repository
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImp(sl()))
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImp(sl()))
    ..registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImp(sl()))
    ..registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImp(sl()))
    // Data source
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImp(sl(), sl()))
    ..registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImp(sl()))
    ..registerLazySingleton<ChatsRemoteDataSource>(
        () => ChatsRemoteDataSourceImp(sl(), sl()))
    ..registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImpl(sl(), sl()),
    )
    // common
    ..registerLazySingleton(() => UploadPhoto())
    // Additional dependencies
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
