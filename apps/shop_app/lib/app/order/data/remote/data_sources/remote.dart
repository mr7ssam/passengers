import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

import '../../../../../common/const/const.dart';

class OrderRemote {
  final Dio _dio;

  OrderRemote(this._dio);

  Future<Response> getOrders({bool ready = false}) async {
    return await _dio.get(
      APIRoutes.order.getAll,
      queryParameters: {'isReady': ready},
    );
  }

  Future<Response> markAsReady(Params params) async {
    return await _dio.patch(
      APIRoutes.order.markAsReady,
      queryParameters: params.toMap(),
    );
  }
}
