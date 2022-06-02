import 'package:customer_app/common/const/const.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

import '../models/shop_details_dto.dart';
import '../models/shop_dto.dart';

class ShopRemote {
  final Dio _dio;

  ShopRemote(this._dio);

  Future<List<ShopDTO>> getShops(Params params) async {
    return throwAppException(
      () => _dio
          .get(
            APIRoutes.shop.getAllShops,
            queryParameters: params.toMap(),
          )
          .then(
            (value) =>
                (value.data as List).map((e) => ShopDTO.fromMap(e)).toList(),
          ),
    );
  }

  Future<ShopDetailsDTO> getShopDetails(Params params) async {
    return throwAppException(
      () => _dio
          .get(
            APIRoutes.shop.getAllShops,
            queryParameters: params.toMap(),
          )
          .then(
            (value) => ShopDetailsDTO.fromMap(value.data),
          ),
    );
  }
}
