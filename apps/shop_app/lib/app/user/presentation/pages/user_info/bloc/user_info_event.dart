part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoEvent {}

class UseInfoStarted extends UserInfoEvent {}
class UseInfoSubmitted extends UserInfoEvent {}


