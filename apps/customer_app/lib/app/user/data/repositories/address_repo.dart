import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:customer_app/app/user/domain/repositories/address_repo.dart';
import 'package:p_core/p_core.dart';

import '../remote/address_bot_storage.dart';
import '../remote/address_remote.dart';

class AddressRepo implements IAddressRepo {
  final AddressRemote _addressRemote;
  final BotStorageListMixin<Address> addressBotStorage;

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
  Stream<List<Address>?> stream() {
    _s();
    return addressBotStorage.stream;
  }

  _s() {
    getAll().then((value) {
      addressBotStorage.write(value);
    }).catchError((e) {
      addressBotStorage.addError(e);
    });
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
  Future<Address> update(Address params) {
    final index = addressBotStorage.read()!.indexOf(params);
    return _addressRemote.update(params).then(
      (value) {
        final address = value.toModel();
        addressBotStorage.update(address, index);
        return address;
      },
    );
  }

  @override
  Future<bool> setCurrent(Address params) {
    return _addressRemote.setCurrentLocation(params).then(
      (value) {
        var list = addressBotStorage
            .read()!
            .map((e) => e.copyWith(isCurrentLocation: e.id == params.id))
            .toList();
        print(list.length);
        addressBotStorage.write(
          list,
        );
        return value;
      },
    );
  }

  @override
  List<Address> read() {
    return addressBotStorage.read() ?? [];
  }
}
