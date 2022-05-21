import 'package:shop_app/app/category/application/api.dart';
import 'package:shop_app/app/category/application/facade.dart';
import 'package:shop_app/app/category/data/remote/remote.dart';
import 'package:shop_app/app/category/data/repositories/repo.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../app/category/domain/repositories/repo.dart';

Future<void> category() async {
  si.registerLazySingleton(() => CategoryRemote(si()));

  si.registerLazySingleton<ICategoryRepo>(() => CategoryRepo(si()));

  si.registerLazySingleton<CategoryFacade>(() => CategoryFacade(si(), si()));

  si.registerLazySingleton<CategoryApi>(
    () => CategoryApi(
      si(),
    ),
  );
}
