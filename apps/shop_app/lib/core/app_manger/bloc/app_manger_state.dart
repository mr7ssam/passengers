part of 'app_manger_bloc.dart';

enum AppState {
  splash,
  authenticated,
  unAuthenticated,
}

@immutable
class AppMangerState {
  final AppState state;

  const AppMangerState({required this.state});

  const AppMangerState.initial() : this(state: AppState.splash);

  AppMangerState copyWith({
    AppState? state,
  }) {
    return AppMangerState(
      state: state ?? this.state,
    );
  }

  @override
  String toString() {
    return {'state': state.name}.toString();
  }
}
