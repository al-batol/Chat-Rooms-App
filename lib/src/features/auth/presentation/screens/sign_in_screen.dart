import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/core/widgets/decorated_button.dart';
import 'package:chat_rooms/core/utils/show_proccess_indicator.dart';
import 'package:chat_rooms/core/utils/show_snack_bar.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/auth/authentication_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:chat_rooms/src/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in-screen';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();

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
          'Log in',
          style: TextStyle(
            color: darkWhiteFontColor,
            fontSize: getFontSize(13.5),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getHeight(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  color: darkWhiteFontColor,
                  fontSize: getFontSize(11.5),
                ),
              ),
              SizedBox(height: getHeight(10)),
              CustomTextField(
                controller: emailCtr,
                hintText: 'Enter your email',
              ),
              SizedBox(height: getHeight(20)),
              Text(
                'Password',
                style: TextStyle(
                  color: darkWhiteFontColor,
                  fontSize: getFontSize(11.5),
                ),
              ),
              SizedBox(height: getHeight(10)),
              CustomTextField(
                controller: passwordCtr,
                hintText: 'Enter your password',
                isPassword: true,
              ),
              SizedBox(height: getHeight(20)),
              BlocListener<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
                  if (state is CreatingUser) {
                    showProcessIndicator(context);
                  } else if (state is SignedIn) {
                    context.read<UserAuthCubit>().getUserData();
                    context.read<UserAuthCubit>().sendEmailVerification();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showSnackBar(context, state.message, true);
                  } else if (state is AuthenticationError) {
                    showSnackBar(context, state.message, false);
                    Navigator.pop(context);
                  }
                },
                child: DecoratedButton(
                  text: 'Login',
                  isCreatedRoom: false,
                  action: () async {
                    await context.read<AuthenticationCubit>().signInWithEmail(
                          email: emailCtr.text.trim(),
                          password: passwordCtr.text.trim(),
                        );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Haven\'t singed up yet',
                      style: TextStyle(
                        color: darkWhiteFontColor,
                        fontSize: getFontSize(11.5),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          SignupScreen.routeName,
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: getFontSize(10.5),
                          color: oceanColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
