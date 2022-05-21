part of 'app_manger_bloc.dart';

enum AppState {
  splash,
  authenticated,
  unAuthenticated,
}

@immutable
class AppMangerState {
  final AppState state;
  final User? user;

  const AppMangerState({required this.state, this.user});

  const AppMangerState.initial() : this(state: AppState.splash, user: null);

  AppMangerState copyWith({
    AppState? state,
    User? user,
  }) {
    return AppMangerState(
      state: state ?? this.state,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'AppMangerState{state: $state, user: $user}';
  }
}
