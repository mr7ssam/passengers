import 'package:customer_app/app/cart/domain/entities/checkout.dart';
import 'package:customer_app/app/cart/domain/repositories/repo.dart';
import 'package:p_core/p_core.dart';

class CartFacade {
  final ICartRepo _cartRepo;

  CartFacade(this._cartRepo);

  Future<ApiResult<Checkout>> checkout(Params params) {
    return toApiResult(() => _cartRepo.checkout(params));
  }

  Future<ApiResult<void>> addOrder(Params params) {
    return toApiResult(() => _cartRepo.addOrder(params));
  }
}
