import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/core/page_state/page_state.dart';
import 'package:shop_app/features/user/application/api.dart';
import 'package:shop_app/features/user/domain/entities/user_profile.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
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
          failure: (message) {
            emit(state.copyWith(
              profileState: PageState.error(error: message),
            ));
          },
        );
      }
    });
  }

  final UserAPI _userAPI;
}
