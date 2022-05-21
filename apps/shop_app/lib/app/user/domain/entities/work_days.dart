enum WorkType {
  none,
  daily,
  custom,
}

class WorkDays {
  final WorkType type;
  final List<int> days;

  WorkDays({
    required this.type,
    this.days = const [],
  });

  factory WorkDays.daily() => WorkDays(
        type: WorkType.daily,
        days: List.generate(7, (index) => index),
      );

  factory WorkDays.custom({
    required List<int> days,
  }) =>
      WorkDays(
        type: WorkType.custom,
        days: days,
      );

  factory WorkDays.none() => WorkDays(
        type: WorkType.none,
      );

  WorkDays copyWith({
    WorkType? type,
    List<int>? days,
  }) {
    return WorkDays(
      type: type ?? this.type,
      days: days ?? this.days,
    );
  }
}
