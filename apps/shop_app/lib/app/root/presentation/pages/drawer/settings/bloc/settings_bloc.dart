import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/user/application/api.dart';
import 'package:shop_app/app/user/domain/entities/user_profile.dart';
import 'package:shop_app/app/user/domain/params/edit_image_params.dart';
import 'package:shop_app/core/extension.dart';
import 'package:shop_app/core/page_state/page_state.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with RetryBlocMixin {
  SettingsBloc(this._userAPI) : super(SettingsState.init()) {
    on<SettingsEvent>((event, emit) async {
      if (event is SettingsStarted) {
        emit(state.copyWith(
          profileState: const PageState.loading(),
        ));
        final result = await _userAPI.getProfile();
        result.when(
          success: (data) {
            emit(state.copyWith(
              profileState: PageState.loaded(data: data),
            ));
          },
          failure: (message, e) {
            emit(state.copyWith(
              profileState: PageState.error(exception: e),
            ));
          },
        );
      } else if (event is SettingsUserImageEdited) {
        _userAPI.updateImage(FileParams(event.file));
      }
    });
  }

  final UserAPI _userAPI;
}
