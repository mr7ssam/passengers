import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    Key? key,
    required this.imagePath,
    this.replacement,
    this.size,
  }) : super(key: key);

  final String? imagePath;
  final Widget? replacement;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? Size.square(80.r);
    return SizedBox.fromSize(
      size: effectiveSize,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular((effectiveSize.width / 4)),
        ),
        child: imagePath?.isNotEmpty ?? false
            ? AppNetworkImage(
                fit: BoxFit.cover,
                url: imagePath!,
              )
            : replacement ??
                Icon(
                  PIcons.outline_profile,
                  size: 36.r,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
      ),
    );
  }
}
