import 'package:p_core/p_core.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/domain/entities/product_details.dart';

import '../entities/home_data.dart';

abstract class IProductRepo {
  Future<PagingDataWrapper<Product>> getAllProducts(PagingParams params);
  Future<void> addProduct(FormDataParams params);
  Future<void> deleteProduct(Params params);
  Future<void> updateProduct(FormDataParams params);
  Future<void> updateProductPrice(Params params);
  Future<void> updateAvailability(Params params);
  Future<ProductDetails> getProductDetails(Params params);
  Future<HomeData> homeData();
}
