import 'package:p_core/p_core.dart';
import 'package:shop_app/app/product/data/remote/data_sources/remote.dart';
import 'package:shop_app/app/product/domain/entities/home_data.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/domain/entities/product_details.dart';
import 'package:shop_app/app/product/domain/repositories/repo.dart';

class ProductRepo extends IProductRepo {
  final ProductRemote _remote;

  ProductRepo(this._remote);

  @override
  Future<PagingDataWrapper<Product>> getAllProducts(PagingParams params) {
    return _remote.getAll(params).then(
      (value) {
        final data = value.data.map((e) => e.toModel()).toList();
        return value.copyWithData(data: data);
      },
    );
  }

  @override
  Future<void> addProduct(FormDataParams params) {
    return _remote.addProduct(params);
  }

  @override
  Future<void> updateProduct(FormDataParams params) {
    return _remote.updateProduct(params);
  }

  @override
  Future<ProductDetails> getProductDetails(Params params) {
    return _remote.getProductDetails(params).then(
          (value) => value.toModel(params.toMap()['id']),
        );
  }

  @override
  Future<void> deleteProduct(Params params) {
    return _remote.deleteProduct(params);
  }

  @override
  Future<HomeData> homeData() {
    return _remote.homeData().then((value) => value.toModel());
  }

  @override
  Future<void> updateProductPrice(Params params) {
    return _remote.updateProductPrice(params);
  }

  @override
  Future<void> updateAvailability(Params params) {
    return _remote.updateAvailability(params);
  }
}
