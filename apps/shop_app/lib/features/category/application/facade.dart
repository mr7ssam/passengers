import 'package:darq/darq.dart';
import 'package:p_network/p_http_client.dart';
import 'package:shop_app/features/category/domain/entities/tag.dart';
import 'package:shop_app/features/category/domain/repositories/repo.dart';

import '../domain/entities/category.dart';

class CategoryFacade {
  final ICategoryRepo categoryRepo;

  CategoryFacade(this.categoryRepo);

  Future<ApiResult<List<Category>>> getAll() {
    return categoryRepo.getAll();
  }

  Future<ApiResult<List<Tag>>> getAllTags() {
    return categoryRepo.getAllTags();
  }

  Future<ApiResult<Tuple2<List<Category>, List<Tag>>>>
  getAllTagsAndCategories() async {
    final categories = getAll();
    final tags = getAllTags();
    final result = await Future.wait<ApiResult>([categories, tags]);
    final mayBeOnFailure =
    result.mayBeOnFailure<Tuple2<List<Category>, List<Tag>>>();
    if (mayBeOnFailure != null) {
      return mayBeOnFailure;
    }

    return ApiResult.success(
      data: Tuple2(
        result[0].whenOrNull(
          success: (data) => data,
        ),
        result[1].whenOrNull(
          success: (data) => data,
        ),
      ),
    );
  }
}
