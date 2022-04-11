import 'dart:io';

import 'package:p_network/p_http_client.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/core/extension.dart';
import 'package:shop_app/features/category/domain/entities/category.dart';
import 'package:shop_app/features/category/domain/entities/tag.dart';
import 'package:shop_app/features/user/presentation/pages/complete_info/components/work_hours_bottom_sheet.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../core/params.dart';

class CompleteInformationParams extends FromDataParams {
  final File? image;
  final List<int> days;
  final String fromTime;
  final String phoneNumber;
  final String toTime;
  final List<String>? contacts;
  final String categoryId;
  final List<String> tagsIds;

  CompleteInformationParams({
    required this.image,
    required this.days,
    required this.fromTime,
    required this.toTime,
    required this.phoneNumber,
    this.contacts = const [],
    required this.categoryId,
    this.tagsIds = const [],
  });

  @override
  FormData toFromData() {
    final map = toMap();
    final formData = FormData.fromMap(map);
    if (image != null) {
      formData.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(image!.path),
      ));
    }
    return formData;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'days': days,
      'fromTime': fromTime,
      'toTime': toTime,
      'contacts': contacts,
      'categoryId': categoryId,
      'tagsIds': tagsIds,
    };
  }

  factory CompleteInformationParams.fromMap(Map<String, dynamic> map) {
    final TimeRange timeRange = map['workHours'] as TimeRange;
    return CompleteInformationParams(
      days: (map['workDays'] as WorkDays).days,
      phoneNumber: map['phoneNumber'] as String,
      fromTime: timeRange.startTime.timeAsString(),
      toTime: timeRange.endTime.timeAsString(),
      image: (map['image'] as FormControl<File?>).value,
      contacts: map['contacts'] as List<String>?,
      categoryId: (map['mainCategory'] as Category).id,
      tagsIds: (map['tags'] as List<Tag>?)
              ?.map((e) => e.id)
              .toList() ??
          [],
    );
  }
}
