import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';

import '../../../../application/facade.dart';
import '../../../../domain/params/login_params.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._userFacade) : super(LoginInitial()) {
    on<LoginEvent>(_handler);
  }

  static const phoneNumberControllerName = 'phoneNumber';
  static const passwordControllerName = 'password';

  final FormGroup form = FormGroup(
    {
      phoneNumberControllerName: FormControl(
        validators: [Validators.required],
      ),
      passwordControllerName: FormControl(
        validators: [Validators.required],
      ),
    },
  );

  final UserFacade _userFacade;

  FutureOr<void> _handler(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginSubmitted) {
      await _mapSubmitted(emit);
    } else if (event is LoginCanceled) {
      _mapLoginCanceled();
    }
  }

  void _mapLoginCanceled() {
    final state = this.state;
    if (state is LoginLoading) {
      state.params.cancelToken.cancel();
    }
  }

  Future<void> _mapSubmitted(Emitter<LoginState> emit) async {
    if (form.isValid()) {
      final loginParams = LoginParams.fromMap(form.value);
      emit(LoginLoading(loginParams));
      form.unfocus();
      final result = await _userFacade.login(loginParams);
      result.when(
        success: (data) => emit(LoginSuccess()),
        failure: (message, e) => emit(LoginFailure(message)),
      );
    }
  }
}
