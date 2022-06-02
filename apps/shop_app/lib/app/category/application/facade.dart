import 'package:darq/darq.dart';
import 'package:p_core/p_core.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/app/category/domain/repositories/repo.dart';
import 'package:shop_app/app/user/application/api.dart';

import '../domain/entities/category.dart';

class CategoryFacade {
  final ICategoryRepo categoryRepo;
  final UserAPI userAPI;

  CategoryFacade(this.categoryRepo, this.userAPI);

  Future<ApiResult<List<Category>>> getAll() {
    return toApiResult(() => categoryRepo.getAll());
  }

  Future<ApiResult<List<Tag>>> getShopTags() {
    return toApiResult(() => categoryRepo.getShopTags());
  }

  Future<ApiResult<List<Tag>>> getPublicTags() {
    return toApiResult(() => categoryRepo.getPublicTags());
  }

  Future<ApiResult<Tag>> addTag(Params params) {
    return toApiResult(() => categoryRepo.addTag(params));
  }

  Future<ApiResult<void>> deleteTag(Params params) {
    return toApiResult(() => categoryRepo.deleteTag(params));
  }

  Future<ApiResult<void>> updateTag(Params params) {
    return toApiResult(() => categoryRepo.updateTag(params));
  }

  Future<ApiResult<Tuple2<List<Category>, List<Tag>>>>
      getAllTagsAndCategories() async {
    return toApiResult(() async {
      final data = await Future.wait([
        categoryRepo.getAll(),
        categoryRepo.getPublicTags(),
      ]);
      return Tuple2(
        data[0] as List<Category>,
        data[1] as List<Tag>,
      );
    });
  }
}
