import 'package:shop_app/app/user/domain/entities/work_days.dart';
import 'package:time_range_picker/time_range_picker.dart';

class WorkingModel {
  final WorkDays workDays;
  final TimeRange workHours;

  WorkingModel({
    required this.workDays,
    required this.workHours,
  });
}
