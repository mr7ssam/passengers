import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_network/p_http_client.dart';

extension AppExceptionExt on AppException {
  AppException tr() => copyWith(
        message: message.tr(),
      );
}

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

extension IterableExt<T> on Iterable<T> {
  Iterable<T> superJoin(T separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];

    final _l = [iterator.current];
    while (iterator.moveNext()) {
      _l
        ..add(separator)
        ..add(iterator.current);
    }
    return _l;
  }
}

mixin RetryBlocMixin<Event, State> on Bloc<Event, State> {
  Event? lastEvent;

  @mustCallSuper
  @override
  void onEvent(Event event) {
    lastEvent = event;
    super.onEvent(event);
  }

  void retry() {
    if (lastEvent != null) {
      add(lastEvent!);
    }
  }
}
