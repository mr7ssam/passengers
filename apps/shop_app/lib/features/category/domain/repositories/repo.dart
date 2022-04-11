import 'package:p_network/p_http_client.dart';
import 'package:shop_app/features/category/domain/entities/tag.dart';

import '../entities/category.dart';

abstract class ICategoryRepo {
  Future<ApiResult<List<Category>>> getAll();

  Future<ApiResult<List<Tag>>> getAllTags();
}
