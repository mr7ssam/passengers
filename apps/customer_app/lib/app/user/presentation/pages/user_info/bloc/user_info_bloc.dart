import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';

import '../../../../application/facade.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/entities/user_info.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState>
    with RetryBlocMixin {
  UserInfoBloc(this._userFacade) : super(UserInfoInitial()) {
    on<UserInfoEvent>((event, emit) async {
      if (event is UseInfoStarted) {
        await _mapStartedEvent(emit);
      } else if (event is UseInfoSubmitted) {
        await _mapSubmittedEvent();
      }
    });
  }

  final UserFacade _userFacade;

  final controls = _Controls();

  late final form = fb.group(controls._controls);

  Future<void> _mapStartedEvent(Emitter<UserInfoState> emit) async {
    emit(UserInfoLoading());
    final result = await _userFacade.getInfo();
    result.when(
      success: (data) {
        form.value = data.toMap(forAPI: false);

        emit(UserInfoSuccess(data));
      },
      failure: (message, e) {
        emit(UserInfoFailure(e));
      },
    );
  }

  Future<void> _mapSubmittedEvent() async {
    if (form.isValid()) {
      var userInfo = UserInfo.fromMap(form.value);
      EasyLoading.show();
      final result = await _userFacade.updateInfo(userInfo);
      result.when(success: (data) {
        EasyLoading.showSuccess('Saved');
      }, failure: (message, e) {
        EasyLoading.showError(
          message,
        );
      });
    }
  }
}

class _Controls {
  static const nameControllerName = 'fullName';
  static const genderControllerName = 'gender';
  static const dobControllerName = 'dob';

  final name = FormControl<String>(validators: [Validators.required]);
  final gender = FormControl<Gender>(validators: [Validators.required]);
  final dob = FormControl<DateTime>(validators: [Validators.required]);

  late final Map<String, AbstractControl<dynamic>> _controls = {
    nameControllerName: name,
    genderControllerName: gender,
    dobControllerName: dob,
  };
}
