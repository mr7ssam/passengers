import 'package:customer_app/app/products/data/remote/data_sources/product_remote.dart';
import 'package:p_core/p_core.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/product_details.dart';
import '../../domain/repositories/product_repo.dart';

class ProductRepo implements IProductRepo {
  final ProductRemote _productRemote;

  ProductRepo(this._productRemote);

  @override
  Future<List<Product>> getProducts(Params params) async {
    final result = await _productRemote.getProducts(params);

    return result.map((e) => e.toModel()).toList();
  }

  @override
  Future<ProductDetails> getProductDetails(Params params) async {
    final result = await _productRemote.getProductDetails(params);

    return result.toModel('id');
  }
}