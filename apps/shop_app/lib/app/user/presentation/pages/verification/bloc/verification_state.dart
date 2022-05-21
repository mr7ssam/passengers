part of 'verification_bloc.dart';

@immutable
abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationSuccess extends VerificationState {}

class VerificationLoading extends VerificationState {
  final VerificationParams params;

  VerificationLoading(this.params);
}

class VerificationFailure extends VerificationState {
  final String message;

  VerificationFailure(this.message);
}
