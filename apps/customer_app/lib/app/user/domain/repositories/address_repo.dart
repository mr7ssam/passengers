import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:p_core/p_core.dart';

abstract class IAddressRepo {
  Future<List<Address>> getAll();
  Stream<List<Address>?> stream();
  Future<Address> add(Params params);
  Future<Address> update(Params params);
  Future<void> delete(Address address);
}
