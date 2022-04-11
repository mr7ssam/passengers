import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../icons/p_icons.dart';

class CustomReactiveTextField<T> extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? formControlName;
  final IconData? prefix;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? contentColor;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? obscureText;
  final bool readOnly;
  final Map<String, String> Function(FormControl control)? validationMessages;
  final double? iconSize;
  final EdgeInsets? contentPadding;
  final BoxConstraints? prefixIconConstraints;
  final Color? iconColor;
  final Widget? icon;
  final Widget? suffix;
  final ControlValueAccessor<T, String>? valueAccessor;

  const CustomReactiveTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.validationMessages,
    this.formControlName,
    this.prefix,
    this.keyboardType,
    this.focus,
    this.textInputAction,
    this.onTap,
    this.backgroundColor,
    this.contentColor,
    this.controller,
    this.maxLines = 1,
    this.obscureText,
    this.iconSize,
    this.contentPadding,
    this.prefixIconConstraints,
    this.iconColor,
    this.icon,
    this.suffix,
    this.readOnly = false,
    this.valueAccessor,
  }) : super(key: key);

  @override
  _CustomReactiveTextFieldState createState() =>
      _CustomReactiveTextFieldState<T>();
}

class _CustomReactiveTextFieldState<T>
    extends State<CustomReactiveTextField<T>> {
  bool? _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ReactiveTextField<T>(
      formControlName: widget.formControlName,
      obscureText: _obscureText ?? false,
      focusNode: widget.focus,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      onTap: widget.onTap,
      validationMessages: widget.validationMessages,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      valueAccessor: widget.valueAccessor,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        hintText: widget.hintText,
        labelText: widget.labelText,
        icon: widget.icon,
        suffix: widget.suffix,
        suffixIcon: _obscureText != null
            ? IconButton(
                onPressed: _onTapEye,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeInCubic,
                  switchOutCurve: Curves.easeInOutCirc,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    ),
                  ),
                  child: Icon(
                    _obscureText! ? PIcons.outline_hide : PIcons.outline_show,
                    size: widget.iconSize,
                    key: Key(
                      _obscureText.toString(),
                    ),
                  ),
                ),
              )
            : null,
        prefixIcon: widget.prefix != null
            ? Icon(
                widget.prefix,
                size: widget.iconSize ?? themeData.iconTheme.size,
                color: widget.iconColor,
              )
            : null,
        prefixIconConstraints: widget.prefixIconConstraints,
      ),
    );
  }

  void _onTapEye() => setState(() => _obscureText = !_obscureText!);

  @override
  void dispose() {
    super.dispose();
  }
}
