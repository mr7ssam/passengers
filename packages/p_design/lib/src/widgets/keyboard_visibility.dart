import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
    as kv;

class KeyboardVisibilityBuilder extends StatelessWidget {
  final Widget Function()? open;
  final Widget Function() closed;
  final bool animate;
  final Duration duration;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  const KeyboardVisibilityBuilder({
    Key? key,
    this.open,
    required this.closed,
    this.animate = true,
    this.duration = const Duration(milliseconds: 200),
    this.transitionBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kv.KeyboardVisibilityBuilder(
      builder: (_, isKeyboardVisible) {
        if (!animate) {
          return _buildKeyedSubtree(isKeyboardVisible);
        }
        return AnimatedSwitcher(
          duration: duration,
          transitionBuilder: (context, animation) {
            return transitionBuilder?.call(context, animation) ??
                SizeTransition(
                  sizeFactor: animation,
                  child: context,
                );
          },
          child: _buildKeyedSubtree(isKeyboardVisible),
        );
      },
    );
  }

  KeyedSubtree _buildKeyedSubtree(bool isKeyboardVisible) {
    return KeyedSubtree(
      key: ValueKey(isKeyboardVisible),
      child: !isKeyboardVisible ? closed() : open?.call() ?? const SizedBox(),
    );
  }
}
