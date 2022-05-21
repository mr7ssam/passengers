import 'package:shop_app/app/user/domain/entities/work_days.dart';
import 'package:shop_app/app/user/domain/entities/working_model.dart';
import 'package:shop_app/common/utils.dart';
import 'package:time_range_picker/time_range_picker.dart';

class WorkingDTO {
  WorkingDTO({
    required this.days,
    required this.fromTime,
    required this.toTime,
  });

  final List<int> days;
  final String fromTime;
  final String toTime;

  factory WorkingDTO.fromMap(Map<String, dynamic> map) {
    return WorkingDTO(
      days: (map['days'] as List).cast<int>(),
      fromTime: map['fromTime'] as String,
      toTime: map['toTime'] as String,
    );
  }

  WorkingModel toModel() {
    final type = days.length == 7 ? WorkType.daily : WorkType.custom;
    final workDays = WorkDays(type: type, days: days);
    return WorkingModel(
      workDays: workDays,
      workHours: TimeRange(
        startTime: stringToTimeOfDay(fromTime),
        endTime: stringToTimeOfDay(toTime),
      ),
    );
  }
}
