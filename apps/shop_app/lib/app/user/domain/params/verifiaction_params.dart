import 'package:p_core/p_core.dart';

class VerificationParams extends Params {
  final String code;

  VerificationParams(this.code);

  @override
  Map<String, dynamic> toMap() {
    return {'code': code};
  }
}
