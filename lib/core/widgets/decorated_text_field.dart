
import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/rooms/rooms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DecoratedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? hasSearchIcon;
  final double? height;
  final bool? hasMultiLines;
  final bool? isDisables;

  // this is for search
  final Future<void> Function(String, RoomsState)? onChange;

  // this is for room checker
  final String? Function(String?)? onTextChanged;

  const DecoratedTextField({
    Key? key,
    required this.hintText,
    this.hasSearchIcon = false,
    required this.controller,
    this.height,
    this.hasMultiLines = false,
    this.onChange,
    this.isDisables,
    this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = ResponsiveLayout.screenWidth(context);

    double getHeight(double height) {
      return ResponsiveLayout.getHeight(height, context);
    }

    double getWidth(double width) {
      return ResponsiveLayout.getWidth(width, context);
    }

    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
    }

    return Container(

      decoration: BoxDecoration(
        color: searchColor,
        borderRadius: BorderRadius.circular(getWidth(10)),
      ),
      child: TextFormField(
        enabled: isDisables,
        controller: controller,
        cursorColor: lightFontColor,
        style: TextStyle(
          color: Colors.white,
          fontSize: getFontSize(11.5),
          decorationThickness: 0,
        ),
        keyboardType:
            hasMultiLines! ? TextInputType.multiline : TextInputType.text,
        maxLines: hasMultiLines! ? 10 : 1,
        onChanged: (value) async {
          if (onChange != null) {
            await onChange!(value, context.read<RoomsCubit>().state);
          }
        },
        validator: onTextChanged,
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: hasSearchIcon!
              ? const Icon(
                  Icons.search,
                  color: lightFontColor,
                )
              : null,
          hintText: hintText,
          hintStyle: TextStyle(
            color: lightFontColor,
            fontSize: getFontSize(11.5),
          ),

          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
