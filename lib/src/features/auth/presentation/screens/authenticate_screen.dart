import 'package:chat_rooms/core/utils/user_auth.dart';
import 'package:chat_rooms/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AuthenticateScreen extends StatelessWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      UserAuth.sendEmailVerification();
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                      (route) => false);
                },
                child: const Text('go back')),
            const Text(
                'we\'ve sent to you an authentication link, please check your email'),
          ],
        ),
      ),
    );
  }
}
