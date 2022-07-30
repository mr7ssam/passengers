import 'package:customer_app/app/cart/data/remote/models/checkout_dto.dart';
import 'package:customer_app/common/const/const.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

class CartRemote {
  final Dio _dio;

  CartRemote(this._dio);

  Future<CheckoutDTO> checkout(Params params) async {
    final parameters = params.toMap();
    final costResponse = await _dio.get(
      APIRoutes.order.expectedCost,
      queryParameters: parameters,
    );
    final orderDetailsResponse = await _dio.post(
      APIRoutes.order.myCart,
      data: parameters,
    );
    final data = {
      'total': costResponse.data['cost'],
      'time': costResponse.data['time'],
      'items': orderDetailsResponse.data
    };
    return throwAppException(
      () => CheckoutDTO.fromMap(data),
    );
  }

  Future<void> addOrder(Params params) async {
    await _dio.post(
      APIRoutes.order.addOrder,
      data: params.toMap(),
    );
    return;
  }
}
