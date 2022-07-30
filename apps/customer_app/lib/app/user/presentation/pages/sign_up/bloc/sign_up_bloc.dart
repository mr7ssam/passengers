import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/app/user/domain/entities/user.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';

import '../../../../application/facade.dart';
import '../../../../domain/params/sign_up_params.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._userFacade) : super(SignUpInitial()) {
    on<SignUpEvent>(_handler);
  }

  final controls = _SingUpControls();
  late final FormGroup form = FormGroup(
    controls._controls,
  );

  FutureOr<void> _handler(SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event is SignUpSubmitted) {
      if (form.isValid()) {
        await _mapSubmitted(emit);
      }
    } else if (event is SignUpCanceled) {
      _mapSignUpCanceled();
    }
  }

  final UserFacade _userFacade;

  void _mapSignUpCanceled() {
    final state = this.state;
    if (state is SignUpLoading) {
      state.params.cancelToken.cancel();
    }
  }

  Future<void> _mapSubmitted(Emitter<SignUpState> emit) async {
    final params = SignUpParams.fromMap(form.value);
    emit(SignUpLoading(params));

    final result = await _userFacade.signUp(params);
    result.when(
      success: (data) => emit(SignUpSuccess()),
      failure: (message, e) => emit(SignUpFailure(message)),
    );
  }
}

class _SingUpControls {
  static const nameControllerName = 'fullName';
  static const phoneControllerName = 'phoneNumber';
  static const passwordControllerName = 'password';
  static const genderControllerName = 'gender';
  static const dobControllerName = 'dob';

  final name = FormControl<String>(validators: [Validators.required]);
  final phone = FormControl<String>(validators: [Validators.required]);
  final password = FormControl<String>(validators: [Validators.required]);
  final gender = FormControl<Gender>(validators: [Validators.required]);
  final dob = FormControl<DateTime>(validators: [Validators.required]);

  late final Map<String, AbstractControl<dynamic>> _controls = {
    nameControllerName: name,
    phoneControllerName: phone,
    passwordControllerName: password,
    genderControllerName: gender,
    dobControllerName: dob,
  };
}
