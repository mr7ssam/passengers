import '../../../domain/entities/user.dart';

class UserDto {
  UserDto({
    required this.id,
    required this.userName,
    required this.name,
    required this.phoneNumber,
    required this.accountStatus,
    required this.accessToken,
    required this.refreshToken,
    required this.categoryName,
    required this.imagePath,
  });

  final String id;
  final String userName;
  final String? name;
  final String? phoneNumber;
  final int accountStatus;
  final String accessToken;
  final String refreshToken;
  final String? categoryName;
  final String? imagePath;

  factory UserDto.fromAPI(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] as String,
      name: map['name'] as String?,
      userName: map['userName'] as String,
      phoneNumber: map['phoneNumber'] as String?,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      categoryName: map['categoryName'] as String?,
      accountStatus: map['accountStatus'] as int,
      imagePath: map['imagePath'] as String?,
    );
  }

  User toModel() {
    return User(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      userName: userName,
      accessToken: accessToken,
      refreshToken: refreshToken,
      accountStatus: AccountStatus.values[accountStatus],
      imagePath: imagePath,
    );
  }

  Map<String, dynamic> tokenMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
