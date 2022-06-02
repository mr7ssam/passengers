import 'package:customer_app/app/user/domain/entities/user.dart';
import 'package:p_core/p_core.dart';

class SignUpParams extends Params {
  final String phoneNumber;
  final String password;
  final String fullName;
  final Gender gender;
  final DateTime dob;

  SignUpParams({
    required this.phoneNumber,
    required this.password,
    required this.fullName,
    required this.gender,
    required this.dob,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      'fullName': fullName,
      'gender': gender.index + 1,
      'dob': dob.toIso8601String(),
    };
  }

  factory SignUpParams.fromMap(Map<String, dynamic> map) {
    return SignUpParams(
        phoneNumber: map['phoneNumber'],
        password: map['password'] as String,
        fullName: map['fullName'] as String,
        dob: map['dob'],
        gender: map['gender']);
  }
}
