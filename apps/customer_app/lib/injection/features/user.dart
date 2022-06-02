import '../../app/user/application/api.dart';
import '../../app/user/application/facade.dart';
import '../../app/user/data/local/data_sources/token_storage.dart';
import '../../app/user/data/local/data_sources/user_storage.dart';
import '../../app/user/data/remote/remote.dart';
import '../../app/user/data/repositories/repo.dart';
import '../../app/user/domain/repositories/repo.dart';
import '../service_locator.dart';

Future<void> user() async {
  si.registerSingleton<UserRemote>(UserRemote(si()));

  si.registerSingleton<UserStorage>(UserStorage(si()));

  si.registerSingleton<TokenStorageImpl>(TokenStorageImpl(si()));

  si.registerSingleton<IUserRepo>(
    UserRepo(
      remote: si(),
      tokenStorage: si(),
      userStorage: si(),
    ),
  );

  si.registerSingleton<UserFacade>(
    UserFacade(
      userRepo: si(),
    ),
  );

  si.registerSingleton<UserAPI>(
    UserAPI(
      si(),
    ),
  );
}
