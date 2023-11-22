import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController? secondPassword;
  final String hintText;
  final bool? isPassword;
  final String? Function(String? name, String? forPassword)? validator;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.secondPassword,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
    }

    return TextFormField(
      controller: controller,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: getFontSize(11.5),
        decorationThickness: 0,
      ),
      obscureText: isPassword!,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: lightFontColor),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: oceanColor, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF696D97), width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
      validator: (value) {
        if (validator != null) {
          return validator!(value, secondPassword!.text.trim());
        }
        return null;
      },
    );
  }
}
