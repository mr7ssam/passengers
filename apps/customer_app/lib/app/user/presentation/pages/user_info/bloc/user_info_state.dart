part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoState {}

class UserInfoInitial extends UserInfoState {}

class UserInfoSuccess extends UserInfoState {
  final UserInfo userInfo;

  UserInfoSuccess(this.userInfo);
}

class UserInfoLoading extends UserInfoState {
  final UserInfo? userInfo;

  UserInfoLoading({this.userInfo});
}

class UserInfoFailure extends UserInfoState {
  final AppException exception;

  UserInfoFailure(this.exception);
}
