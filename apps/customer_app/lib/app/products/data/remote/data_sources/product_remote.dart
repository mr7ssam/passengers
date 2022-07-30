import 'package:customer_app/app/products/data/remote/models/home_data_dto.dart';
import 'package:customer_app/common/const/const.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

import '../models/product_details_dto.dart';
import '../models/product_dto.dart';

class ProductRemote {
  final Dio _dio;

  ProductRemote(this._dio);

  Future<PagingDataWrapper<ProductDTO>> getProducts(Params params) async {
    return throwAppException(
      () => _dio
          .get(
        APIRoutes.product.getProducts,
        queryParameters: params.toMap(),
      )
          .then(
        (value) {
          final data =
              (value.data as List).map((e) => ProductDTO.fromMap(e)).toList();
          return PagingDataWrapper(
            data: data,
            paging: Paging.fromJson(
              value.pagingData(),
            ),
          );
        },
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

  Future<HomeDataDTO> homeData() async {
    return throwAppException(
      () => _dio
          .get(
            APIRoutes.product.home,
          )
          .then(
            (value) => HomeDataDTO.fromMap(value.data),
          ),
    );
  }
}
