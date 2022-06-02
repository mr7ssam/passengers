import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class FilledButton extends ElevatedButton {
  const FilledButton({
    required super.onPressed,
    required super.child,
    super.key,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
  });

  factory FilledButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) = ElevatedButtonWithIcon;

  @override
  ButtonStyle themeStyleOf(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = ElevatedButton.styleFrom(
      onPrimary: scheme.onPrimary,
      primary: scheme.primary,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
    return style.merge(super.themeStyleOf(context));
  }
}

class TonalButton extends ElevatedButton {
  const TonalButton({
    required super.onPressed,
    required super.child,
    super.key,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
  });

  factory TonalButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) = ElevatedButtonWithIcon;

  @override
  ButtonStyle themeStyleOf(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = ElevatedButton.styleFrom(
      onPrimary: scheme.onPrimaryContainer,
      primary: scheme.primaryContainer,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
    return style.merge(super.themeStyleOf(context));
  }
}

class ElevatedButtonWithIcon extends FilledButton implements TonalButton {
  ElevatedButtonWithIcon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _ElevatedButtonWithIconChild(icon: icon, label: label),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding),
        );
  }
}

class _ElevatedButtonWithIconChild extends StatelessWidget {
  const _ElevatedButtonWithIconChild(
      {Key? key, required this.label, required this.icon})
      : super(key: key);

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}
