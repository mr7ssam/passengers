import 'package:flutter/foundation.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/user/application/facade.dart';
import 'package:shop_app/app/user/domain/entities/working_model.dart';
import 'package:shop_app/core/extension.dart';
import 'package:shop_app/core/page_state/page_state.dart';
import 'package:shop_app/core/remote/params.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../../../../user/domain/entities/work_days.dart';

class WorkingSettingsProvider extends ChangeNotifier {
  WorkingSettingsProvider(this._userFacade)
      : _pageState = const PageState.loading();
  final UserFacade _userFacade;

  PageState<WorkingModel> _pageState;

  static const workDaysControlName = 'workDays';
  static const workHoursControlName = 'workHours';

  final workDaysControl = FormControl<WorkDays>(validators: [
    Validators.required,
  ]);

  final hoursControl = FormControl<TimeRange>(validators: [
    Validators.required,
  ]);

  late final form = fb.group({
    workDaysControlName: workDaysControl,
    workHoursControlName: hoursControl,
  });

  PageState<WorkingModel> get pageState => _pageState;

  set pageState(PageState<WorkingModel> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  fetch() async {
    pageState = const PageState.loading();
    final result = await _userFacade.getWorking();
    result.when(
      success: (data) {
        pageState = PageState.loaded(data: data);
        hoursControl.value = data.workHours;
        workDaysControl.value = data.workDays;
      },
      failure: (message, e) {
        pageState = PageState.error(exception: e);
      },
    );
  }

  update() async {
    final data = pageState.data;
    final time = hoursControl.value!;
    pageState = const PageState.loading();
    final result = await _userFacade.updateWorkDaysAndHours(
      days: ParamsWrapper({
        'days': workDaysControl.value!.days,
      }),
      hours: ParamsWrapper({
        'fromTime': time.startTime.timeAsString(),
        'toTime': time.endTime.timeAsString(),
      }),
    );

    result.when(
      success: (_) {
        pageState = PageState.loaded(data: data);
      },
      failure: (message, e) {
        pageState = PageState.error(exception: e);
      },
    );
  }
}
