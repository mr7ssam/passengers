import 'package:customer_app/app/user/data/remote/address_remote.dart';
import 'package:customer_app/app/user/domain/repositories/address_repo.dart';

import '../../app/user/application/api.dart';
import '../../app/user/application/facade.dart';
import '../../app/user/data/local/data_sources/token_storage.dart';
import '../../app/user/data/local/data_sources/user_storage.dart';
import '../../app/user/data/remote/address_bot_storage.dart';
import '../../app/user/data/remote/remote.dart';
import '../../app/user/data/repositories/address_repo.dart';
import '../../app/user/data/repositories/repo.dart';
import '../../app/user/domain/entities/address.dart';
import '../../app/user/domain/repositories/repo.dart';
import '../service_locator.dart';

Future<void> user() async {
  si.registerSingleton<UserRemote>(UserRemote(si()));

  si.registerSingleton<AddressRemote>(AddressRemote(si()));
  si.registerSingleton<BotStorageListMixin<Address>>(AddressBotStorage());

  si.registerSingleton<UserStorage>(UserStorage(si()));

  si.registerSingleton<TokenStorageImpl>(TokenStorageImpl(si()));

  si.registerSingleton<IUserRepo>(
    UserRepo(
      remote: si(),
      tokenStorage: si(),
      userStorage: si(),
    ),
  );

  si.registerSingleton<IAddressRepo>(
    AddressRepo(si(), si()),
  );

  si.registerSingleton<UserFacade>(
    UserFacade(
      userRepo: si(),
      addressRepo: si(),
    ),
  );

  si.registerSingleton<UserAPI>(
    UserAPI(
      si(),
    ),
  );
}
