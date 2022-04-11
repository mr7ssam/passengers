part of 'complete_information_bloc.dart';

@immutable
abstract class CompleteInformationEvent {}


class CompleteInformationSubmitted extends CompleteInformationEvent {}

class CompleteInformationCanceled extends CompleteInformationEvent {}
