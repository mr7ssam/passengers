import 'package:darq/darq.dart';
import 'package:p_network/p_http_client.dart';
import 'package:shop_app/app/category/application/facade.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';

import '../../../core/remote/params.dart';
import '../domain/entities/category.dart';

class CategoryApi {
  final CategoryFacade _categoryFacade;

  CategoryApi(this._categoryFacade);

  Future<ApiResult<List<Category>>> getAll() {
    return _categoryFacade.getAll();
  }

  Future<ApiResult<List<Tag>>> getShopTags() {
    return _categoryFacade.getShopTags();
  }

  Future<ApiResult<Tag>> addTag(Params params) {
    return _categoryFacade.addTag(params);
  }

  Future<ApiResult<Tuple2<List<Category>, List<Tag>>>>
      getAllTagsAndCategories() async {
    return _categoryFacade.getAllTagsAndCategories();
  }
}
