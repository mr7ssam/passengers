part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {}
class SignUpCanceled extends SignUpEvent {}
