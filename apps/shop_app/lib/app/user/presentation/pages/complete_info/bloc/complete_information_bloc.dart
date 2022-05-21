import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/user/application/facade.dart';
import 'package:shop_app/app/user/presentation/pages/complete_info/steps/step_one_provider.dart';
import 'package:shop_app/app/user/presentation/pages/complete_info/steps/step_two_provider.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../../../domain/params/complete_inforamtion_params.dart';

part 'complete_information_event.dart';
part 'complete_information_state.dart';

class CompleteInformationBloc
    extends Bloc<CompleteInformationEvent, CompleteInformationState> {
  final UserFacade _facade;

  final CompleteInfoStepOneProvider stepOneProvider =
      CompleteInfoStepOneProvider();
  final CompleteInfoStepTowProvider stepTowProvider =
      CompleteInfoStepTowProvider(si())..fetch();

  CompleteInformationBloc(this._facade) : super(CompleteInformationInitial()) {
    on<CompleteInformationEvent>((event, emit) async {
      if (event is CompleteInformationSubmitted) {
        final params = CompleteInformationParams.fromMap(
          {}
            ..addAll(stepOneProvider.form.value)
            ..addAll(stepTowProvider.form.value),
        );
        emit(CompleteInformationLoading(params));

        final result = await _facade.completeInformation(
          params,
        );
        result.when(
          success: (data) => emit(CompleteInformationSuccess()),
          failure: (message, e) => emit(CompleteInformationFailure(message)),
        );
      }
    });
  }
}
