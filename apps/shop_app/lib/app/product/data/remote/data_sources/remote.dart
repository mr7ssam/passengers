import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';
import 'package:shop_app/app/product/data/remote/models/product_dto.dart';
import 'package:shop_app/common/const/const.dart';

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
            return PagingDataWrapper(
              data: data,
              paging: Paging.fromJson(response.pagingData()),
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

  Future<void> addProduct(FormDataParams params) async {
    final formData = await params.toFromData();
    await _dio.post(
      APIRoutes.product.addProduct,
      data: formData,
    );
  }

  Future<void> updateProduct(FormDataParams params) async {
    final formData = await params.toFromData();
    await _dio.put(
      APIRoutes.product.updateProduct,
      data: formData,
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
