import 'dart:developer';

import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/core/utils/assets_strings.dart';
import 'package:chat_rooms/core/widgets/decorated_button.dart';
import 'package:chat_rooms/core/widgets/photo_card.dart';
import 'package:chat_rooms/core/utils/show_proccess_indicator.dart';
import 'package:chat_rooms/core/utils/show_snack_bar.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/auth/authentication_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:chat_rooms/src/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();
  final TextEditingController passConfCtr = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
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
          'Sign up',
          style: TextStyle(
            color: darkWhiteFontColor,
            fontSize: getFontSize(13.5),
          ),
        ),
      ),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is CreatingUser) {
            showProcessIndicator(context);
          } else if (state is SignedIn) {
            context.read<UserAuthCubit>().getUserData(user: state.user);
            context.read<UserAuthCubit>().sendEmailVerification();
            showSnackBar(context, state.message, true);
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is AuthenticationError) {
            showSnackBar(context, state.message, false);
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(getHeight(15)),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      color: darkWhiteFontColor,
                      fontSize: getFontSize(11.5),
                    ),
                  ),
                  SizedBox(height: getHeight(10)),
                  CustomTextField(
                    controller: nameCtr,
                    hintText: 'Enter your name',
                  ),
                  SizedBox(height: getHeight(20)),
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
                    secondPassword: passConfCtr,
                    validator: context.read<AuthenticationCubit>().validator,
                    isPassword: true,
                  ),
                  SizedBox(height: getHeight(20)),
                  Text(
                    'Password Confirmation',
                    style: TextStyle(
                      color: darkWhiteFontColor,
                      fontSize: getFontSize(11.5),
                    ),
                  ),
                  SizedBox(height: getHeight(10)),
                  CustomTextField(
                    controller: passConfCtr,
                    hintText: 'Re-write your password',
                    secondPassword: passwordCtr,
                    validator: context.read<AuthenticationCubit>().validator,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  DecoratedButton(
                      text: 'Register',
                      isCreatedRoom: false,
                      action: () async {
                        if (formKey.currentState!.validate()) {
                          await context.read<AuthenticationCubit>().createUser(
                                name: nameCtr.text.trim(),
                                email: emailCtr.text.trim(),
                                password: passwordCtr.text.trim(),
                              );
                        }
                      }),
                  Row(
                    children: [
                      Container(
                        height: 1,
                        width: w / 2.5,
                        decoration: const BoxDecoration(
                          color: lightFontColor,
                        ),
                      ),
                      SizedBox(
                        width: w * 0.125,
                        child: Text(
                          'or',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getFontSize(10),
                            color: darkWhiteFontColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: w / 2.5,
                        decoration: const BoxDecoration(
                          color: lightFontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * .01),
                  SizedBox(
                    width: w,
                    height: w * 0.15,
                    child: MaterialButton(
                      onPressed: () async {
                        await context
                            .read<AuthenticationCubit>()
                            .signInWithGoogle();
                      },
                      shape: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFF696D97),
                      )),
                      child: Row(
                        children: [
                          PhotoCard(
                            size: w * .1,
                            svgName: googleAvatarSvg,
                            hasBorder: false,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Continue With Google',
                                style: TextStyle(
                                  fontSize: getFontSize(11.5),
                                  color: darkWhiteFontColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * .02),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Already singed up yet?',
                          style: TextStyle(
                            color: darkWhiteFontColor,
                            fontSize: getFontSize(11.5),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              SignInScreen.routeName,
                            );
                          },
                          child: Text(
                            'Sign in',
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
        ),
      ),
    );
  }
}
