import 'package:p_network/p_http_client.dart';

abstract class Params {
  final CancelToken cancelToken = CancelToken();

  Map<String, dynamic> toMap();
}

abstract class FromDataParams extends Params {
  FormData toFromData();
}
