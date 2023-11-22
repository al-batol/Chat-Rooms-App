import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_rooms/core/utils/app_colors.dart';
import 'package:chat_rooms/core/utils/assets_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhotoCard extends StatelessWidget {
  final double size;
  final String? photo;
  final String? svgName;
  final bool? hasBorder;
  final bool? isUploadingPhoto;

  const PhotoCard({
    Key? key,
    required this.size,
    this.photo,
    this.svgName = avatarSvg,
    this.hasBorder = true,
    this.isUploadingPhoto = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: hasBorder!
            ? Border.all(
                color: oceanColor,
                width: 1.5,
              )
            : null,
        image: photo != null && photo != '' && !isUploadingPhoto!
            ? DecorationImage(
                image: CachedNetworkImageProvider(photo!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: isUploadingPhoto!
          ? const Center(child: CircularProgressIndicator())
          : photo == null || photo == ''
              ? SvgPicture.asset(
                  svgName!,
                )
              : null,
    );
  }
}
