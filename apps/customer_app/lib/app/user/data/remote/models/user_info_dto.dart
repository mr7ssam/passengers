import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_info.dart';

class UserInfoDTO {
  UserInfoDTO({
    required this.fullName,
    required this.dob,
    required this.gender,
  });

  final String fullName;
  final String dob;
  final int gender;

  UserInfo toModel() {
    return UserInfo(
        fullName: fullName,
        gender: Gender.values.byIndex(gender),
        dob: DateTime.parse(dob));
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'gender': gender,
      'dob': dob,
    };
  }

  factory UserInfoDTO.fromMap(Map<String, dynamic> map) {
    return UserInfoDTO(
      fullName: map['fullName'] ?? "",
      dob: map['dob'],
      gender: map['genderType'],
    );
  }
}
