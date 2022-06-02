import 'package:p_core/p_core.dart';
import 'package:shop_app/app/product/domain/entities/home_data.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';

import '../domain/entities/product_details.dart';
import '../domain/repositories/repo.dart';

class ProductFacade {
  ProductFacade(this.productRepository);

  final IProductRepo productRepository;

  Future<ApiResult<PagingDataWrapper<Product>>> getAll(PagingParams params) {
    return toApiResult(() => productRepository.getAllProducts(params));
  }

  Future<ApiResult<void>> add(FormDataParams params) {
    return toApiResult(() => productRepository.addProduct(params));
  }

  Future<ApiResult<void>> update(FormDataParams params) {
    return toApiResult(() => productRepository.updateProduct(params));
  }

  Future<ApiResult<void>> updatePrice(Params params) {
    return toApiResult(() => productRepository.updateProductPrice(params));
  }

  Future<ApiResult<void>> updateAvailability(Params params) {
    return toApiResult(() => productRepository.updateAvailability(params));
  }

  Future<ApiResult<void>> delete(Params params) {
    return toApiResult(() => productRepository.deleteProduct(params));
  }

  Future<ApiResult<ProductDetails>> getProductDetails(Params params) {
    return toApiResult(() => productRepository.getProductDetails(params));
  }

  Future<ApiResult<HomeData>> getHomeData() {
    return toApiResult(() => productRepository.homeData());
  }
}
