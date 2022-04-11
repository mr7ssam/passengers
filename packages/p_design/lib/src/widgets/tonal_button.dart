import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class TonalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final Widget child;
  const TonalButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textButtonStyle = Theme.of(context).textButtonTheme.style!.copyWith(
          backgroundColor:
              MaterialStateProperty.all(PColors.primarySwatch.shade50),
        );
    final effectStyle =
        style != null ? textButtonStyle.merge(style) : textButtonStyle;
    return TextButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: effectStyle,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
