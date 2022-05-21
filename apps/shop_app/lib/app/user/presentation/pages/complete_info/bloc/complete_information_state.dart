part of 'complete_information_bloc.dart';

@immutable
abstract class CompleteInformationState {}

class CompleteInformationInitial extends CompleteInformationState {}

class CompleteInformationSuccess extends CompleteInformationState {}

class CompleteInformationLoading extends CompleteInformationState {
  final CompleteInformationParams params;

  CompleteInformationLoading(this.params);
}

class CompleteInformationFailure extends CompleteInformationState {
  final String message;

  CompleteInformationFailure(this.message);
}
