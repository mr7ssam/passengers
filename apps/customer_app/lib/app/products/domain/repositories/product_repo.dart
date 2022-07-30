import 'package:customer_app/app/products/domain/entities/home_data.dart';
import 'package:p_core/p_core.dart';

import '../entities/product.dart';
import '../entities/product_details.dart';

abstract class IProductRepo {
  Future<PagingDataWrapper<Product>> getProducts(PagingParams pagingParams);
  Future<ProductDetails> getProductDetails(Params params);
  Future<HomeData> homeData();
}
