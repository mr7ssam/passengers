class User {
  User({
    required this.id,
    required this.fullName,
    required this.type,
    required this.phoneNumber,
    required this.accessToken,
    required this.refreshToken,
    required this.gender,
    this.imagePath,
  });

  //guest user
  User.guest({
    this.id = '_guest_id_',
    this.fullName = 'guest',
    this.type = UserType.guest,
    this.phoneNumber = 'none',
    this.accessToken = 'none',
    this.refreshToken = 'none',
    this.gender = Gender.male,
    this.imagePath,
  });

  final String id;
  final String fullName;
  final UserType type;
  final String phoneNumber;
  final String accessToken;
  final String refreshToken;
  final Gender gender;
  final String? imagePath;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'gender': gender.index,
      'imagePath': imagePath,
      'userType': type.index,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      gender: Gender.values[(map['gender'])],
      imagePath: map['imagePath'] as String?,
      type: UserType.values[map['userType']],
    );
  }

  User copyWith({
    String? id,
    String? fullName,
    UserType? type,
    String? phoneNumber,
    String? accessToken,
    String? refreshToken,
    Gender? gender,
    String? imagePath,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      gender: gender ?? this.gender,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> tokenMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userType': type.index,
    };
  }
}

enum Gender { none, male, female }

enum UserType {
  guest,
  normal,
}
