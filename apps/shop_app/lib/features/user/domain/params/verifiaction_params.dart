import 'package:shop_app/core/params.dart';

class VerificationParams extends Params {
  final String code;

  VerificationParams(this.code);

  @override
  Map<String, dynamic> toMap() {
    return {'code': code};
  }
}
