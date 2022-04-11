import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/generated/locale_keys.g.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../components/work_hours_bottom_sheet.dart';
import 'step_one_provider.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    Key? key,
    required this.stepOneProvider,
  }) : super(key: key);

  final CompleteInfoStepOneProvider stepOneProvider;

  @override
  Widget build(BuildContext context) {
    final of = Theme.of(context);
    return ReactiveForm(
      formGroup: stepOneProvider.form,
      child: Column(
        children: [
          StreamBuilder<File?>(
            stream: stepOneProvider.imageControl.valueChanges,
            builder: (context, snapshot) => CircleAvatar(
              radius: 38.r,
              child: EditableImage(
                size: 76.r,
                editIconColor: of.colorScheme.primary,
                image: snapshot.data != null
                    ? Image.file(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      )
                    : null,
                onChange: (image) {
                  stepOneProvider.imageControl.value = image;
                },
              ),
            ),
          ),
          Space.vM4,
          CustomTitle(
            icon: const Icon(PIcons.outline_date___time),
            label: Text(
              LocaleKeys.user_complete_information_working_time_title.tr(),
            ),
          ),
          Space.vM2,
          CustomReactiveTextField<WorkDays>(
            formControlName: CompleteInfoStepOneProvider.workDaysControlName,
            valueAccessor: WorkDaysValueAccessor(),
            onTap: () {
              _onSelectWorkDaysPressed(context);
            },
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_required.tr(),
            },
            suffix: const Icon(PIcons.outline_arrow___right__1),
            readOnly: true,
            hintText: LocaleKeys.user_complete_information_work_days.tr(),
          ),
          Space.vM2,
          CustomReactiveTextField<TimeRange>(
            formControlName: CompleteInfoStepOneProvider.workHoursControlName,
            onTap: () async {
              await _onSelectWorkHoursPressed(context);
            },
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_required.tr(),
            },
            suffix: const Icon(PIcons.outline_arrow___right__1),
            valueAccessor: HoursValueAccessor(context),
            readOnly: true,
            hintText: LocaleKeys.user_complete_information_work_hours.tr(),
          ),
          Space.vL1,
          CustomTitle(
            icon: const Icon(PIcons.outline_info_circle),
            label: Text(
              LocaleKeys.user_complete_information_contact_title.tr(),
            ),
          ),
          Space.vM2,
          CustomReactiveTextField<String>(
            keyboardType: const TextInputType.numberWithOptions(
              signed: false,
              decimal: false,
            ),
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_required.tr(),
            },
            formControlName: CompleteInfoStepOneProvider.phoneNumberControlName,
            onTap: () {},
            prefix: PIcons.outline_phone,
            hintText: LocaleKeys.user_phone_number.tr(),
          ),
          Space.vM2,
        ],
      ),
    );
  }

  Future<void> _onSelectWorkHoursPressed(BuildContext context) async {
    TimeRange result = await showTimeRangePicker(
      context: context,
      autoAdjustLabels: true,
      handlerRadius: 8.r,
      strokeWidth: 4.r,
      interval: const Duration(minutes: 10),
      snap: true,
      labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
          .asMap()
          .entries
          .map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
    );
    stepOneProvider.hoursControl.value = result;
  }

  void _onSelectWorkDaysPressed(BuildContext context) {
    showModalBottomSheet(
      constraints: const BoxConstraints.expand(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return WorkDaysBottomSheet(
          initValue: stepOneProvider.workDaysControl.value,
          onChanged: (value) {
            stepOneProvider.workDaysControl.value = value;
          },
        );
      },
    );
  }
}

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
