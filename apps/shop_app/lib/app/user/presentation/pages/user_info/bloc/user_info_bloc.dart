import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:meta/meta.dart';
import 'package:p_core/p_core.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/user/application/facade.dart';
import 'package:shop_app/app/user/domain/entities/user_info.dart';

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

  static const categoriesControlName = 'category';
  static const shopNameControlName = 'name';
  static const phoneNumberControlName = 'phoneNumber';
  static const businessLineAddressControllerName = 'address';
  static const locationControllerName = 'location';

  final addressControl = FormControl<String>(validators: [Validators.required]);
  final locationControl = FormControl<LocationResult>();
  final categoriesControl = FormControl<Category>();
  final shopNameControl =
      FormControl<String>(validators: [Validators.required]);
  final phoneNumberControl = FormControl<String>();

  late final form = fb.group({
    categoriesControlName: categoriesControl,
    shopNameControlName: shopNameControl,
    phoneNumberControlName: phoneNumberControl,
    businessLineAddressControllerName: addressControl,
    locationControllerName: locationControl,
  });

  Future<void> _mapStartedEvent(Emitter<UserInfoState> emit) async {
    emit(UserInfoLoading());
    final result = await _userFacade.getInfo();
    result.when(
      success: (data) {
        form.value = data.toMap(filterSensitiveData: true);

        emit(UserInfoSuccess(data));
      },
      failure: (message, e) {
        emit(UserInfoFailure(e));
      },
    );
  }

  Future<void> _mapSubmittedEvent() async {
    if (form.valid) {
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
    } else {
      form.markAllAsTouched();
    }
  }
}
