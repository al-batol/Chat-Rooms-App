import 'package:chat_rooms/core/helper/app_router.dart';
import 'package:chat_rooms/core/helper/providers.dart';
import 'package:chat_rooms/core/services/injection_container.dart';
import 'package:chat_rooms/core/is_user_signed_in.dart';
import 'package:chat_rooms/firebase_options.dart';
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
      providers: BlocProviders.appProviders,
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
