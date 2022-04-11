import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/core/extension.dart';
import 'package:shop_app/features/category/application/api.dart';
import 'package:shop_app/features/category/domain/entities/category.dart';
import 'package:shop_app/features/user/application/facade.dart';
import 'package:shop_app/features/user/domain/entities/user_info.dart';

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

  Future<void> _mapSubmittedEvent() async {
     if (form.valid) {
      var userInfo = UserInfo.fromMap(form.value);
      EasyLoading.show();
      final result = await _userFacade.updateInfo(userInfo);
      result.when(success: (data) {
        EasyLoading.showSuccess('Saved');
      }, failure: (message) {
        EasyLoading.showError(message, maskType: EasyLoadingMaskType.clear);
      });
    } else {
      form.markAllAsTouched();
    }
  }

  static const categoriesControlName = 'category';
  static const shopNameControlName = 'name';
  static const phoneNumberControlName = 'phoneNumber';

  final categoriesControl = FormControl<Category>();
  final shopNameControl = FormControl<String>(validators: [
    Validators.required,
  ]);
  final phoneNumberControl = FormControl<String>();

  late final form = fb.group({
    categoriesControlName: categoriesControl,
    shopNameControlName: shopNameControl,
    phoneNumberControlName: phoneNumberControl,
  });

  Future<void> _mapStartedEvent(Emitter<UserInfoState> emit) async {
    emit(UserInfoLoading());
    final result = await _userFacade.getInfo();
    result.when(
      success: (data) {
        shopNameControl.value = data.name;
        categoriesControl.value = data.category;
        emit(UserInfoSuccess(data));
      },
      failure: (message) {
        emit(UserInfoFailure(message));
      },
    );
  }

  final UserFacade _userFacade;
}
