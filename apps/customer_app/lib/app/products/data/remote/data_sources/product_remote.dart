import 'package:customer_app/common/const/const.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

import '../models/product_details_dto.dart';
import '../models/product_dto.dart';

class ProductRemote {
  final Dio _dio;

  ProductRemote(this._dio);

  Future<List<ProductDTO>> getProducts(Params params) async {
    return throwAppException(
      () => _dio
          .get(
            APIRoutes.product.getProducts,
            queryParameters: params.toMap(),
          )
          .then(
            (value) =>
                (value.data as List).map((e) => ProductDTO.fromMap(e)).toList(),
          ),
    );
  }

  Future<ProductDetailsDTO> getProductDetails(Params params) async {
    return throwAppException(
      () => _dio
          .get(
            APIRoutes.product.getProductDetails,
            queryParameters: params.toMap(),
          )
          .then(
            (value) => ProductDetailsDTO.fromMap(value.data),
          ),
    );
  }
}
