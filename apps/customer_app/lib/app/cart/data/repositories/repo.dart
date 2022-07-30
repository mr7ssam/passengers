import 'package:customer_app/app/cart/data/remote/data_sources/remote.dart';
import 'package:p_core/p_core.dart';

import '../../domain/entities/checkout.dart';
import '../../domain/repositories/repo.dart';

class CartRepo extends ICartRepo {
  final CartRemote remote;

  CartRepo(this.remote);

  @override
  Future<Checkout> checkout(Params params) async {
    final orderDetails = await remote.checkout(params);
    return throwAppException(
        () => orderDetails.toModel(params.toMap()['addressId']));
  }

  @override
  Future<void> addOrder(Params params) {
    return throwAppException(
      () => remote.addOrder(params),
    );
  }
}
