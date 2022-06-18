import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:customer_app/app/user/domain/repositories/address_repo.dart';
import 'package:p_core/p_core.dart';

import '../remote/address_bot_storage.dart';
import '../remote/address_remote.dart';

class AddressRepo implements IAddressRepo {
  final AddressRemote _addressRemote;
  final BotStorageMixin2<Address> addressBotStorage;

  AddressRepo(this._addressRemote, this.addressBotStorage);

  @override
  Future<List<Address>> getAll() {
    return _addressRemote.getAll().then(
          (value) => value
              .map(
                (e) => e.toModel(),
              )
              .toList(),
        );
  }

  @override
  Stream<List<Address>?> stream() async* {
    _s();
    yield* addressBotStorage.stream;
  }

  _s() {
    try {
      getAll().then((value) {
        addressBotStorage.write(value);
      });
    } on AppException catch (e) {
      addressBotStorage.addError(e);
    }
  }

  @override
  Future<Address> add(Params params) {
    return _addressRemote.add(params).then(
      (value) {
        final address = value.toModel();
        addressBotStorage.add(address);
        return address;
      },
    );
  }

  @override
  Future<void> delete(Address address) {
    return _addressRemote.delete(address).then(
      (value) {
        addressBotStorage.remove(address);
      },
    );
  }

  @override
  Future<Address> update(Params params) {
    return _addressRemote.update(params).then(
      (value) {
        final address = value.toModel();
        addressBotStorage.add(address);
        return address;
      },
    );
  }
}
