import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../icons/p_icons.dart';

class PAppBar extends AppBar implements PreferredSizeWidget {
  PAppBar({
    Key? key,
    String? title,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
  }) : super(
          key: key,
          title: title != null ? Text(title) : null,
          elevation: 0,
          leadingWidth: 55.w,
          toolbarHeight: 50.h,
          bottom: bottom,
          centerTitle: true,
          actions: actions,
        );
}

class PBackButton extends StatelessWidget {
  const PBackButton({Key? key, this.color, this.iconSize}) : super(key: key);
  final Color? color;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return RPadding(
      padding: const EdgeInsets.all(4.0),
      child: IconButton(
        constraints: BoxConstraints.expand(height: 35.w, width: 35.w),
        icon: Icon(
          PIcons.outline_arrow___left_1,
          size: iconSize ?? 20.r,
          color: color,
        ),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('iconSize', iconSize));
  }
}
