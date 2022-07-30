part of '../../../app_manger/bloc/app_manger_bloc.dart';

@immutable
abstract class AppMangerEvent {
  const AppMangerEvent();
}

class AppMangerStarted extends AppMangerEvent {}

class AppMangerLoggedOut extends AppMangerEvent {}

class AppMangerStateChanged extends AppMangerEvent {
  const AppMangerStateChanged({required this.state});

  final AppState state;
}

class AppMangerUserChanged extends AppMangerEvent {
  const AppMangerUserChanged({required this.user});

  final User? user;
}
