import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../icons/p_icons.dart';
import 'image_avatar.dart';
import 'text.dart';

class ListTileCard extends StatelessWidget {
  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;
  final Widget? leading;
  final String? leadingImage;
  final Widget? trailing;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const ListTileCard({
    Key? key,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.leading,
    this.trailing,
    this.leadingImage,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = this.title ??
        YouText.titleMedium(
          titleText!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        );
    return InkWell(
      onTap: onTap,
      child: RPadding(
        padding: padding ?? const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ??
                ImageAvatar(
                  imagePath: leadingImage,
                  size: Size.square(60.r),
                  replacement: const Icon(PIcons.outline_leg_chicken),
                ),
            Expanded(
              child: RPadding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    if (subtitle != null || subtitleText != null)
                      subtitle ??
                          YouText.bodySmall(
                            subtitleText!,
                          ),
                  ],
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
