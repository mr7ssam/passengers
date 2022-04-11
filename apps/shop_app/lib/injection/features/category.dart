import 'package:shop_app/features/category/application/api.dart';
import 'package:shop_app/features/category/application/facade.dart';
import 'package:shop_app/features/category/data/remote/remote.dart';
import 'package:shop_app/features/category/data/repositories/repo.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../features/category/domain/repositories/repo.dart';

Future<void> category() async {
  si.registerLazySingleton(() => CategoryRemote(si()));

  si.registerLazySingleton<ICategoryRepo>(
      () => CategoryRepo(si()));

  si.registerLazySingleton<CategoryFacade>(
      () => CategoryFacade(si()));

  si.registerLazySingleton<CategoryApi>(
    () => CategoryApi(
      si(),
    ),
  );
}
