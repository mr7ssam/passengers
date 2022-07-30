import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/app/user/application/facade.dart';
import 'package:customer_app/app/user/domain/entities/user.dart';
import 'package:customer_app/injection/service_locator.dart';
import 'package:p_network/p_refresh_token.dart';

part 'app_manger_event.dart';
part 'app_manger_state.dart';

class AppMangerBloc extends Bloc<AppMangerEvent, AppMangerState> {
  AppMangerBloc({this.doBeforeOpen}) : super(const AppMangerState.initial()) {
    on<AppMangerEvent>(_handler);
  }

  late final StreamSubscription<AuthStatus> _authStreamSubscription;
  late final StreamSubscription<User?> _userStreamSubscription;
  late final UserFacade _userFacade;
  final FutureOr<void> Function()? doBeforeOpen;

  FutureOr<void> _handler(
      AppMangerEvent event, Emitter<AppMangerState> emit) async {
    if (event is AppMangerStarted) {
      final delayed = Future.delayed(const Duration(seconds: 4));
      await doBeforeOpen?.call();
      await delayed;
      _userFacade = si<UserFacade>();
      _authStreamSubscription = _userFacade.authStream.listen(_authListener);
      _userStreamSubscription = _userFacade.userStream.listen(_userListener);
    } else if (event is AppMangerStateChanged) {
      emit(state.copyWith(state: event.state));
    } else if (event is AppMangerUserChanged) {
      emit(state.copyWith(user: event.user));
    } else if (event is AppMangerLoggedOut) {
      _userFacade.logout();
    }
  }

  void _userListener(User? event) {
    add(AppMangerUserChanged(user: event));
  }

  void _authListener(AuthStatus event) {
    late final AppState newState;
    switch (event.status) {
      case Status.initial:
        newState = AppState.splash;
        break;
      case Status.authenticated:
        newState = AppState.authenticated;
        break;
      case Status.unauthenticated:
        newState = AppState.unAuthenticated;
        break;
    }
    add(AppMangerStateChanged(state: newState));
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _userStreamSubscription.cancel();
    return super.close();
  }
}
