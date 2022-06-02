import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../app/user/domain/entities/work_days.dart';
import '../generated/locale_keys.g.dart';

class HoursValueAccessor extends ControlValueAccessor<TimeRange, String> {
  final BuildContext context;

  HoursValueAccessor(this.context);

  @override
  String? modelToViewValue(TimeRange? modelValue) {
    if (modelValue == null) {
      return null;
    } else {
      return [
        LocaleKeys.user_complete_information_work_hours.tr() + ':',
        modelValue.startTime.format(context),
        'to',
        modelValue.endTime.format(context)
      ].join(' ');
    }
  }

  @override
  TimeRange? viewToModelValue(String? viewValue) {
    return control?.value;
  }
}

class WorkDaysValueAccessor extends ControlValueAccessor<WorkDays, String> {
  @override
  String? modelToViewValue(WorkDays? modelValue) {
    late String value;
    if (modelValue == null || modelValue.type.when(WorkType.none)) {
      return null;
    } else if (modelValue.type.when(WorkType.daily)) {
      value = 'Daily';
    } else {
      value = 'Custom';
    }
    return [LocaleKeys.user_complete_information_work_days.tr() + ':', value]
        .join(' ');
  }

  @override
  WorkDays? viewToModelValue(String? viewValue) {
    return control?.value;
  }
}
