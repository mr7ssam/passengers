import 'dart:io';

import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/app/user/domain/entities/work_days.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../../../core/mixins/disposable_mixin.dart';

class CompleteInfoStepOneProvider with WizardStep, DisposableMixin {
  static const imageControlName = 'image';
  static const workDaysControlName = 'workDays';
  static const workHoursControlName = 'workHours';
  static const phoneNumberControlName = 'phoneNumber';

  final workDaysControl = FormControl<WorkDays>(validators: [
    Validators.required,
  ]);

  final hoursControl = FormControl<TimeRange>(validators: [
    Validators.required,
  ]);

  final imageControl = FormControl<File?>();

  late final form = fb.group({
    workDaysControlName: workDaysControl,
    imageControlName: imageControl,
    workHoursControlName: hoursControl,
    phoneNumberControlName: FormControl<String>(validators: [
      Validators.required,
    ]),
  });

  void goNext() {
    if (form.valid) {
      wizardController.goNext();
    } else {
      form.markAllAsTouched();
    }
  }
}
