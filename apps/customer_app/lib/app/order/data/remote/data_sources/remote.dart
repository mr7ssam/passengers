import 'dart:developer';

import 'package:customer_app/app/order/data/remote/models/order_tracking_details_dto.dart';
import 'package:customer_app/app/order/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:p_network/p_http_client.dart';

import '../../../../../common/const/const.dart';
import '../../../../../common/signal_r.dart';
import '../models/order_dto.dart';

class OrderRemote {
  final SignalRService signalRService;
  final Dio _dio;

  OrderRemote(this.signalRService, this._dio);

  void orders({
    required ValueChanged<List<OrderDTO>> on,
  }) async {
    final orders = await _dio.get(APIRoutes.order.orders);
    final hubConnection = await signalRService.openHub(
      APIRoutes.ordersHub,
    );
    on(_onOrdersMapper([orders.data]));
    hubConnection.on(
      'UpdateCustomerOrders',
      (arguments) => on(
        _onOrdersMapper(arguments),
      ),
    );
  }

  void order({
    required String orderId,
    required ValueChanged<OrderTrackingDetailsDTO> on,
  }) async {
    final orders = await _dio.get(
      APIRoutes.order.orderById,
      queryParameters: {
        'id': orderId,
      },
    );
    final hubConnection = await signalRService.openHub(
      APIRoutes.ordersHub,
    );

    on(_onOrderDetailsMapper([orders.data]));
    hubConnection.on(
      'UpdateCustomerOrder',
      (arguments) => on(
        _onOrderDetailsMapper(arguments),
      ),
    );
  }

  Future<Response> orderDetails({
    required String orderId,
  }) async {
    final orders = await _dio.get(
      APIRoutes.order.orderDetails,
      queryParameters: {
        'orderId': orderId,
      },
    );
    return orders;
  }

  List<OrderDTO> _onOrdersMapper(List<Object>? data) {
    return (data?[0] as List).map((e) => OrderDTO.fromMap(e)).toList();
  }

  OrderTrackingDetailsDTO _onOrderDetailsMapper(List<Object>? data) {
    log(data.toString());
    return OrderTrackingDetailsDTO.fromMap(data![0] as Map<String, dynamic>);
  }
}
