import 'package:customer_app/app/products/data/remote/models/home_data_dto.dart';
import 'package:customer_app/app/products/domain/entities/product.dart';
import 'package:darq/darq.dart';
import 'package:p_core/p_core.dart';

import '../domain/entities/category.dart';
import '../domain/entities/home_data.dart';
import '../domain/entities/product_details.dart';
import '../domain/entities/shop.dart';
import '../domain/entities/tag.dart';
import '../domain/repositories/category_repo.dart';
import '../domain/repositories/product_repo.dart';
import '../domain/repositories/shop_repo.dart';

class ProductFacade {
  final IShopRepo _shopRepo;
  final ICategoryRepo _categoryRepo;
  final IProductRepo _productRepo;

  ProductFacade({
    required IShopRepo shopRepo,
    required ICategoryRepo categoryRepo,
    required IProductRepo productRepo,
  })  : _shopRepo = shopRepo,
        _categoryRepo = categoryRepo,
        _productRepo = productRepo;

  Future<ApiResult<ShopDetails>> getShopDetails(Params params) {
    return toApiResult(() => _shopRepo.getShopDetails(params));
  }

  Future<ApiResult<List<Shop>>> getShops(PagingParams params) {
    return toApiResult(() => _shopRepo.getShops(params));
  }

  Future<ApiResult<List<Category>>> getCategories(Params params) {
    return toApiResult(() => _categoryRepo.getCategories(params));
  }

  Future<ApiResult<List<Tag>>> getTags(Params params) {
    return toApiResult(() => _categoryRepo.getTags(params));
  }

  Future<ApiResult<PagingDataWrapper<Product>>> getProducts(
      PagingParams params) {
    return toApiResult(() => _productRepo.getProducts(params));
  }

  Future<ApiResult<ProductDetails>> getProductDetails(Params params) {
    return toApiResult(() => _productRepo.getProductDetails(params));
  }

  Future<ApiResult<HomeData>> homeData() {
    return toApiResult(() => _productRepo.homeData());
  }

  Future<ApiResult<Tuple2<List<Shop>, List<Tag>>>> getFoodListData() {
    return toApiResult(
      () async {
        final shops =
            await _shopRepo.getShops(PagingParams(page: 1, pageSize: 10));
        List<Tag> tags = [];
        if (shops.isNotEmpty) {
          tags = await _categoryRepo
              .getTags(ParamsWrapper({'shopId': shops.first.id}));
        }
        return Tuple2(shops, tags);
      },
    );
  }
}
