import 'dart:developer';

import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/app_dimensions.dart';
import 'package:chat_rooms/core/utils/show_proccess_indicator.dart';
import 'package:chat_rooms/core/utils/show_snack_bar.dart';
import 'package:chat_rooms/src/features/home/presentation/cubit/crud_rooms/crud_rooms_cubit.dart';
import 'package:chat_rooms/core/widgets/decorated_button.dart';
import 'package:chat_rooms/core/widgets/decorated_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewRoomScreen extends StatefulWidget {
  static const String routeName = '/create-new-room';
  final bool? isUserVerified;
  final String? roomId;
  final String? name;
  final String? description;
  final String? topic;
  final String? topicId;

  const CreateNewRoomScreen({
    Key? key,
    this.roomId,
    this.name,
    this.description,
    this.topic,
    this.topicId,
    this.isUserVerified = true,
  }) : super(key: key);

  @override
  State<CreateNewRoomScreen> createState() => _CreateNewRoomScreenState();
}

class _CreateNewRoomScreenState extends State<CreateNewRoomScreen> {
  final TextEditingController topicCtr = TextEditingController();
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController descriptionCtr = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    topicCtr.text = widget.topic ?? '';
    nameCtr.text = widget.name ?? '';
    descriptionCtr.text = widget.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    topicCtr.dispose();
    nameCtr.dispose();
    descriptionCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double getHeight(double height) {
      return ResponsiveLayout.getHeight(height, context);
    }

    double getFontSize(double width) {
      return ResponsiveLayout.getFontSize(width, context);
    }

    void pop() {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }

    bool c = false;

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
          widget.roomId != null ? 'Update Room' : 'Create New Room',
          style: TextStyle(
            color: darkWhiteFontColor,
            fontSize: getFontSize(13.5),
          ),
        ),
      ),
      body: BlocListener<CrudRoomsCubit, CrudRoomsState>(
        listener: (context, state) {
          if (state is CreatingNewRoom) {
            showProcessIndicator(context);
          } else if (state is NewRoomCreated) {
            showSnackBar(context, state.message, true);
            pop();
          } else if (state is RoomsError) {
            showSnackBar(context, state.message, false);
            Navigator.pop(context);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getHeight(15)),
          margin: EdgeInsets.only(top: getHeight(15)),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DecoratedTextField(
                    hintText: 'topic',
                    controller: topicCtr,
                    onTextChanged: context.read<CrudRoomsCubit>().validator,
                  ),
                  SizedBox(height: getHeight(20)),
                  DecoratedTextField(
                    hintText: 'room name',
                    controller: nameCtr,
                    onTextChanged: context.read<CrudRoomsCubit>().validator,
                  ),
                  SizedBox(height: getHeight(20)),
                  DecoratedTextField(
                    height: getHeight(200),
                    hintText: 'room description',
                    controller: descriptionCtr,
                    hasMultiLines: true,
                    onTextChanged: context.read<CrudRoomsCubit>().validator,
                  ),
                  SizedBox(height: getHeight(25)),
                  DecoratedButton(
                    action: () async {
                      if (formKey.currentState!.validate()) {
                        await context
                            .read<CrudRoomsCubit>()
                            .createRoomWithTopic(
                              isUserVerified: widget.isUserVerified!,
                              shouldUpdate:
                                  widget.roomId != null ? true : false,
                              roomId: widget.roomId,
                              topicName: topicCtr.text.trim(),
                              roomName: nameCtr.text.trim(),
                              description: descriptionCtr.text.trim(),
                            );
                      }
                    },
                    text: widget.roomId != null ? 'update' : 'submit',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
