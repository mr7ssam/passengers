import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

extension EnumExt on Enum {
  bool when(Enum value) => value == this;
}

extension TimeExt on TimeOfDay {
  String timeAsString() {
    final String hourLabel = _addLeadingZeroIfNeeded(hour);
    final String minuteLabel = _addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }

  String _addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }
}

extension FormGroupExt on AbstractControl {
  bool isValid() {
    if (!valid) {
      markAllAsTouched();
    }
    return valid;
  }
}

extension IterableExt<T> on Iterable<T> {
  Iterable<T> superJoin(T separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return <T>[];

    final _l = <T>[iterator.current];
    while (iterator.moveNext()) {
      _l
        ..add(separator)
        ..add(iterator.current);
    }
    return _l;
  }
}

extension StringEx on String? {
  DateTime? toDateTimeOrNull() {
    if (this == null) return null;
    return DateTime.parse(this!);
  }
}

extension ResponseExt on Response {
  Map<String, dynamic> pagingData() {
    final list = headers['x-pagination'];
    return jsonDecode(list!.first);
  }
}

extension BuildContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  Color get primaryColor => colorScheme.primary;
}
