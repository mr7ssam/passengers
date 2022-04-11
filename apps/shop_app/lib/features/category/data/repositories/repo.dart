import 'package:p_network/p_http_client.dart';
import 'package:shop_app/core/api_utils.dart';
import 'package:shop_app/features/category/data/remote/remote.dart';
import 'package:shop_app/features/category/domain/entities/category.dart';
import 'package:shop_app/features/category/domain/entities/tag.dart';
import 'package:shop_app/features/category/domain/repositories/repo.dart';

class CategoryRepo implements ICategoryRepo {
  final CategoryRemote _categoryRemote;

  CategoryRepo(this._categoryRemote);

  @override
  Future<ApiResult<List<Category>>> getAll() {
    return toApiResult(() => _categoryRemote
        .getAllCategory()
        .then((value) => value.map((e) => e.toModel()).toList()));
  }

  @override
  Future<ApiResult<List<Tag>>> getAllTags() {
    return toApiResult(() => _categoryRemote
        .getAllTags()
        .then((value) => value.map((e) => e.toModel()).toList()));
  }
}
