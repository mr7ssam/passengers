import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class UserImageAvatar extends StatelessWidget {
  const UserImageAvatar({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.r,
      width: 80.r,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: imagePath?.isNotEmpty ?? false
            ? AppNetworkImage(
                url: imagePath!,
              )
            : Icon(
                PIcons.outline_profile,
                size: 36.r,
                color: Theme.of(context).colorScheme.onSurface,
              ),
      ),
    );
  }
}
