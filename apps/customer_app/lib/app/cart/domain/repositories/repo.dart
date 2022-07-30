import 'package:p_core/p_core.dart';

import '../entities/checkout.dart';

abstract class ICartRepo {
  Future<Checkout> checkout(Params params);
  Future<void> addOrder(Params params);
}
