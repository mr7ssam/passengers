import 'package:customer_app/app/user/domain/entities/user.dart';
import 'package:p_core/p_core.dart';

class UserInfo extends Params {
  UserInfo({
    required this.fullName,
    required this.dob,
    required this.gender,
  });

  final String fullName;
  final DateTime dob;
  final Gender gender;

  UserInfo copyWith({
    String? fullName,
    DateTime? dob,
    Gender? gender,
  }) {
    return UserInfo(
      fullName: fullName ?? this.fullName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
    );
  }

  @override
  Map<String, dynamic> toMap({bool forAPI = true}) {
    return {
      'fullName': fullName,
      'dob': forAPI ? dob.toIso8601String() : dob,
      'gender': forAPI ? gender.index : gender,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      fullName: map['fullName'] as String,
      dob: map['dob'],
      gender: map['gender'] as Gender,
    );
  }
}
