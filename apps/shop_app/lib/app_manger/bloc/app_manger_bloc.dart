import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_manger_event.dart';
part 'app_manger_state.dart';

class AppMangerBloc extends Bloc<AppMangerEvent, AppMangerState> {
  AppMangerBloc() : super(const AppMangerState.initial()) {
    on<AppMangerEvent>(_handler);
  }

  FutureOr<void> _handler(AppMangerEvent event, Emitter<AppMangerState> emit) {
    if (event is AppMangerStarted) {
    } else if (event is AppMangerStateChanged) {
      emit(state.copyWith(state: event.state));
    }
  }
}
