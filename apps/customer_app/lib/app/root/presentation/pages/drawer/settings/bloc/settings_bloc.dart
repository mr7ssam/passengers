import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:p_core/p_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../user/application/api.dart';
import '../../../../../../user/domain/entities/user_profile.dart';
import '../../../../../../user/domain/params/edit_image_params.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with RetryBlocMixin {
  SettingsBloc(this._userAPI) : super(SettingsState.init()) {
    on<SettingsEvent>((event, emit) async {
      if (event is SettingsStarted) {
      } else if (event is SettingsUserImageEdited) {
        _userAPI.updateImage(ImageParams(event.file));
      }
    });
  }

  final UserAPI _userAPI;
}
