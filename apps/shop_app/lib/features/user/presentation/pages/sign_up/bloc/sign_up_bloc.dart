import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/features/user/application/facade.dart';

import '../../../../domain/params/sign_up_params.dart';
import '../steps/step_one_provider.dart';
import '../steps/step_two_provider.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with WizardStep {
  SignUpBloc(this._userFacade) : super(SignUpInitial()) {
    on<SignUpEvent>(_handler);
  }

  FutureOr<void> _handler(SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event is SignUpSubmitted) {
      await _mapSubmitted(emit);
    } else if (event is SignUpCanceled) {
      _mapSignUpCanceled();
    }
  }

  final UserFacade _userFacade;
  final StepOneProvider stepOneProvider = StepOneProvider();
  final StepTwoProvider stepTowProvider = StepTwoProvider();

  void _mapSignUpCanceled() {
    final state = this.state;
    if (state is SignUpLoading) {
      state.params.cancelToken.cancel();
    }
  }

  Future<void> _mapSubmitted(Emitter<SignUpState> emit) async {
    final params = SignUpParams.fromMap(
      {}
        ..addAll(stepOneProvider.form.value)
        ..addAll(stepTowProvider.form.value),
    );
    emit(SignUpLoading(params));

    final result = await _userFacade.signUp(params);
    result.when(
      success: (data) => emit(SignUpSuccess()),
      failure: (message) => emit(SignUpFailure(message)),
    );
  }

  @override
  Future<void> close() {
    stepOneProvider.dispose();
    stepTowProvider.dispose();
    return super.close();
  }
}
