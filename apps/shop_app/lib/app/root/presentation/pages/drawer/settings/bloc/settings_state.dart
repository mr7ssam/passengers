part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final PageState<UserProfile> profileState;

  const SettingsState({required this.profileState});

  factory SettingsState.init() =>
      const SettingsState(profileState: PageState.init());

  SettingsState copyWith({
    PageState<UserProfile> ? profileState,
  }) {
    return SettingsState(
      profileState: profileState ?? this.profileState,
    );
  }
}
