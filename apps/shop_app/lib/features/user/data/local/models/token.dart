import 'package:p_network/p_refresh_token.dart';

class AuthTokenModel extends AuthToken {
  AuthTokenModel({
    required String accessToken,
    String? refreshToken,
  }) : super(accessToken: accessToken, refreshToken: refreshToken);

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
    };
  }

  factory AuthTokenModel.fromMap(Map<String, dynamic> data) {
    return AuthTokenModel(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
    );
  }
}
