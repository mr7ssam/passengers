import '../../domain/entities/address.dart';
import 'package:bot_storage/bot_storage.dart';

class AddressBotStorage extends BotStorage<List<Address>>
    with BotStorageMixin, BotStorageListMixin<Address> {
  @override
  void delete() {
    super.delete();
  }

  @override
  void write(value) {
    super.write(value);
  }
}

mixin BotStorageListMixin<T> on BotStorageMixin<List<T>> {
  List<T> _values = [];
  @override
  read() {
    return _values;
  }

  @override
  void write(value) {
    _values = value ?? [];
    super.write(value);
  }

  void add(T value) {
    write(List.from(_values)..add(value));
  }

  void update(T value, int index) {
    write(List.from(_values)..[index] = value);
  }

  void remove(T value) {
    write(List.from(_values)..remove(value));
  }

  @override
  Stream<List<T>?> get stream => super.stream.skip(1);
}
