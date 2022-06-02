import 'package:p_core/p_core.dart';

class LoginParams extends Params {
  LoginParams({required this.userName, required this.password});

  final String userName;
  final String password;

  @override
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(
      userName: map['userName'] as String,
      password: map['password'] as String,
    );
  }
}
