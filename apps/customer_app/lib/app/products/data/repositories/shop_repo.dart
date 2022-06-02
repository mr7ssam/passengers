import 'package:p_core/p_core.dart';

import '../../domain/entities/shop.dart';
import '../../domain/repositories/shop_repo.dart';
import '../remote/data_sources/shop_remote.dart';

class ShopRepo extends IShopRepo {
  final ShopRemote _shopRemote;

  ShopRepo(this._shopRemote);

  @override
  Future<ShopDetails> getShopDetails(Params params) async {
    final result = await _shopRemote.getShopDetails(params);
    return result.toModel();
  }

  @override
  Future<List<Shop>> getShops(PagingParams params) async {
    final result = await _shopRemote.getShops(params);
    return result.map((e) => e.toModel()).toList();
  }
}
