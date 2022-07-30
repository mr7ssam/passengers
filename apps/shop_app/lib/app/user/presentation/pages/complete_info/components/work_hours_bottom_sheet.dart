import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/user/domain/entities/work_days.dart';

class WorkDaysBottomSheet extends StatefulWidget {
  final WorkDays? initValue;
  final ValueChanged<WorkDays> onChanged;

  const WorkDaysBottomSheet({
    Key? key,
    this.initValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<WorkDaysBottomSheet> createState() => _WorkDaysBottomSheetState();
}

class _WorkDaysBottomSheetState extends State<WorkDaysBottomSheet> {
  late WorkDays _workDays;

  @override
  void initState() {
    _workDays = widget.initValue ?? WorkDays.none();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapperWidget(title: 'Select work days', children: [
      Space.vL1,
      CheckboxListTile(
        title: const Text('Daily'),
        value: _workDays.type.when(WorkType.daily),
        onChanged: _onDailySelected,
      ),
      CheckboxListTile(
        title: const Text('Custom'),
        value: _workDays.type.when(WorkType.custom),
        onChanged: _onCustomSelected,
      ),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 256),
        transitionBuilder: (child, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: child,
          );
        },
        child: !(_workDays.type.when(WorkType.custom))
            ? const SizedBox()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      7,
                      (index) => CheckboxListTile(
                        value: _workDays.days.contains(index),
                        title: Text(
                          DateFormat.EEEE().format(
                            DateTime(1, 1, index),
                          ),
                        ),
                        onChanged: (value) {
                          _onDaySelected(value, index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
      )
    ]);
  }

  void _onCustomSelected(value) {
    setState(() {
      _workDays = WorkDays.custom(days: []);
      widget.onChanged(_workDays);
    });
  }

  void _onDailySelected(value) {
    setState(() {
      _workDays = WorkDays.daily();
      widget.onChanged(_workDays);
    });
  }

  void _onDaySelected(bool? value, int index) {
    if (value ?? false) {
      _workDays = _workDays.copyWith(
        days: _workDays.days..add(index),
      );
    } else {
      _workDays = _workDays.copyWith(
        days: _workDays.days..removeWhere((element) => element == index),
      );
    }
    setState(() {});
    widget.onChanged(_workDays);
  }
}
