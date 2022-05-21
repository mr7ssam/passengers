import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'disposable_mixin.dart';

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