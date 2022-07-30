import '../../../domain/entities/user.dart';

class UserDto {
  UserDto({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.accessToken,
    required this.refreshToken,
    required this.imagePath,
    required this.gender,
  });

  final String id;
  final String fullName;
  final String phoneNumber;
  final int gender;
  final String accessToken;
  final String refreshToken;
  final String? imagePath;

  factory UserDto.fromAPI(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      imagePath: map['imagePath'] as String?,
      gender: map['genderType'],
    );
  }

  User toModel() {
    return User(
      id: id,
      type: UserType.normal,
      phoneNumber: phoneNumber,
      fullName: fullName,
      accessToken: accessToken,
      refreshToken: refreshToken,
      gender: Gender.values[gender],
      imagePath: imagePath,
    );
  }
}
