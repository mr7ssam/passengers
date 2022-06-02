import 'dart:io';

import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../entities/work_days.dart';

class CompleteInformationParams extends FormDataParams {
  final File? image;
  final List<int> days;
  final String fromTime;
  final String phoneNumber;
  final String toTime;
  final List<String>? contacts;
  final String categoryId;
  final List<Tag> tags;

  CompleteInformationParams({
    required this.image,
    required this.days,
    required this.fromTime,
    required this.toTime,
    required this.phoneNumber,
    this.contacts = const [],
    required this.categoryId,
    this.tags = const [],
  });

  @override
  Future<FormData> toFromData() async {
    final map = toMap();
    final formData = FormData.fromMap(map);
    if (image != null) {
      formData.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(
          (await compressImage(image!))!.path,
        ),
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
      'tags': tags.map((e) => e.toMap()).toList(),
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
      tags: (map['tags'] as List<Tag>?) ?? [],
    );
  }
}
