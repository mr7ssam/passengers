import 'dart:convert';

import 'package:p_network/p_http_client.dart';
import 'package:shop_app/app/product/data/remote/models/product_dto.dart';
import 'package:shop_app/common/const/const.dart';
import 'package:shop_app/core/remote/api_utils.dart';
import 'package:shop_app/core/remote/data_wrappers.dart';
import 'package:shop_app/core/remote/params.dart';

import '../models/home_data_dto.dart';
import '../models/product_details_dto.dart';

class ProductRemote {
  ProductRemote(this._dio);

  final Dio _dio;

  Future<PagingDataWrapper<ProductDTO>> getAll(Params params) {
    return throwAppException(
      () {
        return _dio
            .get(APIRoutes.product.getAllProducts,
                queryParameters: params.toMap())
            .then(
          (response) {
            final data = List<ProductDTO>.from(
              response.data.map(
                (e) => ProductDTO.fromMap(e),
              ),
            );
            var list = response.headers['x-pagination'];
            var jsonDecode2 = jsonDecode(list!.first);
            return PagingDataWrapper(
              data: data,
              paging: Paging.fromJson(jsonDecode2),
            );
          },
        );
      },
    );
  }

  Future<void> deleteProduct(Params params) {
    return _dio.delete(
      APIRoutes.product.delete,
      queryParameters: params.toMap(),
    );
  }

  Future<void> addProduct(FormDataParams params) {
    return _dio.post(
      APIRoutes.product.addProduct,
      data: params.toFromData(),
    );
  }

  Future<void> updateProduct(FormDataParams params) {
    return _dio.put(
      APIRoutes.product.updateProduct,
      data: params.toFromData(),
    );
  }

  Future<void> updateProductPrice(Params params) {
    return _dio.put(
      APIRoutes.product.updateProductPrice,
      queryParameters: params.toMap(),
    );
  }

  Future<void> updateAvailability(Params params) {
    return _dio.put(
      APIRoutes.product.updateAvailability,
      queryParameters: params.toMap(),
    );
  }

  Future<ProductDetailsDto> getProductDetails(Params params) {
    return throwAppException(
      () {
        return _dio
            .get(
              APIRoutes.product.getProductDetails,
              queryParameters: params.toMap(),
            )
            .then((value) => ProductDetailsDto.fromMap(value.data));
      },
    );
  }

  Future<HomeDataDTO> homeData() {
    return throwAppException(
      () {
        return _dio
            .get(
              APIRoutes.product.home,
            )
            .then((value) => HomeDataDTO.fromMap(value.data));
      },
    );
  }
}
