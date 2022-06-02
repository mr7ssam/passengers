library reactive_intl_phone_form_field;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactivePhoneFormField] that contains a [PhoneFormField].
///
/// This is a convenience widget that wraps a [PhoneFormField] widget in a
/// [ReactivePhoneFormField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveIntlPhoneFormField<T> extends ReactiveFormField<T, PhoneNumber> {
  ReactiveIntlPhoneFormField({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, PhoneNumber>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    bool shouldFormat = true,
    bool enabled = true,
    bool showFlagInInput = true,
    String defaultCountry = 'US',
    PhoneNumber? initialValue,
    double flagSize = 16,
    InputDecoration decoration = const InputDecoration(),
    TextInputType keyboardType = TextInputType.phone,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    VoidCallback? onSubmitted,
    FocusNode? focusNode,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    TextStyle? countryCodeStyle,
    bool enableIMEPersonalizedLearning = true,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactivePhoneFormFieldState<T>;

            state._setFocusNode(focusNode);

            return IntlPhoneField(
              focusNode: state.focusNode,
              onChanged: (number) => field.didChange(number),
              autofocus: autofocus,
              enabled: field.control.enabled,
              decoration: decoration.copyWith(
                errorText: state.errorText,
                enabled: state.control.enabled,
              ),
              disableLengthCheck: true,
              cursorColor: cursorColor,
              autovalidateMode: AutovalidateMode.disabled,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              showCursor: showCursor,
              obscureText: obscureText,
              onSubmitted: onSubmitted != null ? (_) => onSubmitted() : null,
              inputFormatters: inputFormatters,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              keyboardAppearance: keyboardAppearance,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, PhoneNumber> createState() =>
      _ReactivePhoneFormFieldState<T>();
}

class _ReactivePhoneFormFieldState<T>
    extends ReactiveFormFieldState<T, PhoneNumber> {
  FocusNode? _focusNode;
  late FocusController _focusController;

  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    super.onControlValueChanged(value);
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
