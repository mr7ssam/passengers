import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/root/presentation/pages/drawer/settings/pages/working_days/provider.dart';
import 'package:shop_app/app/user/domain/entities/work_days.dart';
import 'package:shop_app/app/user/domain/entities/working_model.dart';
import 'package:shop_app/app/user/presentation/pages/complete_info/components/work_hours_bottom_sheet.dart';
import 'package:shop_app/common/acccessors.dart';
import 'package:shop_app/injection/service_locator.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../../../../../generated/locale_keys.g.dart';

class WorkingDaysSettings extends StatelessWidget {
  const WorkingDaysSettings({Key? key}) : super(key: key);

  static const path = 'working-days-settings';
  static const name = 'working_days_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
          create: (context) => WorkingSettingsProvider(si())..fetch(),
          child: const WorkingDaysSettings()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<WorkingSettingsProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton.icon(
                onPressed: () {
                  provider.update();
                },
                icon: const Icon(
                  PIcons.outline_check,
                ),
                label: const Text('Save')),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.vL1,
            Padding(
              padding: PEdgeInsets.horizontal,
              child: const YouText.titleLarge('Manage schedule work'),
            ),
            ReactiveForm(
              formGroup: provider.form,
              child: Expanded(
                child: Consumer<WorkingSettingsProvider>(
                    builder: (context, provider, child) {
                  return RefreshIndicator(
                    onRefresh: () async => provider.fetch(),
                    child: PageStateBuilder<WorkingModel>(
                      result: provider.pageState,
                      success: (state) {
                        return ListView(
                          padding: PEdgeInsets.listView,
                          children: [
                            Space.vM2,
                            CustomReactiveTextField<WorkDays>(
                              formControlName:
                                  WorkingSettingsProvider.workDaysControlName,
                              valueAccessor: WorkDaysValueAccessor(),
                              onTap: () {
                                _onSelectWorkDaysPressed(context);
                              },
                              validationMessages: (control) => {
                                ValidationMessage.required:
                                    LocaleKeys.validations_required.tr(),
                              },
                              suffix:
                                  const Icon(PIcons.outline_arrow___right__1),
                              readOnly: true,
                              hintText: LocaleKeys
                                  .user_complete_information_work_days
                                  .tr(),
                            ),
                            Space.vM2,
                            CustomReactiveTextField<TimeRange>(
                              formControlName:
                                  WorkingSettingsProvider.workHoursControlName,
                              onTap: () async {
                                await _onSelectWorkHoursPressed(context);
                              },
                              validationMessages: (control) => {
                                ValidationMessage.required:
                                    LocaleKeys.validations_required.tr(),
                              },
                              suffix:
                                  const Icon(PIcons.outline_arrow___right__1),
                              valueAccessor: HoursValueAccessor(context),
                              readOnly: true,
                              hintText: LocaleKeys
                                  .user_complete_information_work_hours
                                  .tr(),
                            ),
                            Space.vL1,
                          ],
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSelectWorkHoursPressed(BuildContext context) async {
    TimeRange? result = await showTimeRangePicker(
      context: context,
      autoAdjustLabels: true,
      handlerRadius: 8.r,
      strokeWidth: 4.r,
      interval: const Duration(minutes: 10),
      snap: true,
      labels: [
        "12 am",
        "3 am",
        "6 am",
        "9 am",
        "12 pm",
        "3 pm",
        "6 pm",
        "9 pm",
      ].asMap().entries.map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
    );
    if (result != null) {
      context.read<WorkingSettingsProvider>().hoursControl.value = result;
    }
  }

  void _onSelectWorkDaysPressed(BuildContext context) {
    var provider = context.read<WorkingSettingsProvider>();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return WorkDaysBottomSheet(
          initValue: provider.workDaysControl.value,
          onChanged: (value) {
            provider.workDaysControl.value = value;
          },
        );
      },
    );
  }
}
