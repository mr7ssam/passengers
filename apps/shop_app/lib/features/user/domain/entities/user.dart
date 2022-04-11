class User {
  User({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.accessToken,
    required this.refreshToken,
    required this.accountStatus,
    required this.name,
    this.imagePath,
  });

  final String id;
  final String userName;
  final String? name;
  final String? phoneNumber;
  final String accessToken;
  final String refreshToken;
  final AccountStatus accountStatus;
  final String? imagePath;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'name': name,
      'phoneNumber': phoneNumber,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accountStatus': accountStatus.index,
      'imagePath': imagePath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      userName: map['userName'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      accountStatus: AccountStatus.values[map['accountStatus']],
      imagePath: map['imagePath'],
    );
  }

  User copyWith({
    String? id,
    String? userName,
    String? name,
    String? phoneNumber,
    String? accessToken,
    String? refreshToken,
    AccountStatus? accountStatus,
    String? imagePath,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      accountStatus: accountStatus ?? this.accountStatus,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

enum AccountStatus {
  draft,
  unCompleted,
  completed,
}
