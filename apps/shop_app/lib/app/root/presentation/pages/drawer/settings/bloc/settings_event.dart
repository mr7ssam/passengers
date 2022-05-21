part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsStarted extends SettingsEvent {}

class SettingsUserImageEdited extends SettingsEvent {
  final File file;

  SettingsUserImageEdited(this.file);
}
