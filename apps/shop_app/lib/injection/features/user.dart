import 'package:shop_app/app/user/application/api.dart';
import 'package:shop_app/app/user/application/facade.dart';
import 'package:shop_app/app/user/data/remote/remote.dart';
import 'package:shop_app/app/user/domain/repositories/repo.dart';
import 'package:shop_app/app/user/presentation/pages/complete_info/bloc/complete_information_bloc.dart';
import 'package:shop_app/app/user/presentation/pages/login/bloc/login_bloc.dart';

import '../../app/user/data/local/data_sources/token_storage.dart';
import '../../app/user/data/local/data_sources/user_storage.dart';
import '../../app/user/data/repositories/repo.dart';
import '../../app/user/presentation/pages/sign_up/bloc/sign_up_bloc.dart';
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

  si.registerFactory<LoginBloc>(
    () => LoginBloc(si()),
  );

  si.registerFactory<SignUpBloc>(
    () => SignUpBloc(si()),
  );

  si.registerFactory<CompleteInformationBloc>(
    () => CompleteInformationBloc(si()),
  );
}
