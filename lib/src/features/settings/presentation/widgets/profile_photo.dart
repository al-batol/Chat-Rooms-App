import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/widgets/photo_card.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/update/update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePhoto extends StatelessWidget {
  final String userId;
  final String photoUrl;
  final double photoSize;
  final double photoPickerSize;

  const ProfilePhoto({
    Key? key,
    required this.userId,
    required this.photoUrl,
    required this.photoSize,
    required this.photoPickerSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String photo = photoUrl;
    return BlocBuilder<UpdateCubit, UpdateState>(builder: (context, state) {
      return Stack(
        children: [
          PhotoCard(
            size: photoSize,
            photo: photo,
            isUploadingPhoto: state is UploadingAvatar ? true : false,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                photo = await context.read<UpdateCubit>().pickPhotoThenUpload(
                      context,
                      userId,
                    );
              },
              child: Container(
                width: photoPickerSize,
                height: photoPickerSize,
                decoration: const BoxDecoration(
                    color: oceanColor, shape: BoxShape.circle),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: photoPickerSize / 2,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
