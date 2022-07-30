import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:p_core/p_core.dart';

abstract class IAddressRepo {
  Future<List<Address>> getAll();
  List<Address> read();
  Stream<List<Address>?> stream();
  Future<Address> add(Params params);
  Future<bool> setCurrent(Address params);
  Future<Address> update(Address params);
  Future<void> delete(Address address);
}
