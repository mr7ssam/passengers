import 'package:customer_app/app/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:p_network/p_refresh_token.dart';

class AuthTokenModel extends AuthToken with EquatableMixin {
  AuthTokenModel({
    required super.accessToken,
    super.refreshToken,
    required this.userType,
  });

  final UserType userType;

  @override
  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
      'userType': userType.index,
    };
  }

  factory AuthTokenModel.fromMap(Map<String, dynamic> data,{UserType? userType}) {
    return AuthTokenModel(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
      userType:userType?? UserType.values[data['userType']],
    );
  }

  @override
  List<Object?> get props => [accessToken];
}
