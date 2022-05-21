import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/core/remote/params.dart';

import '../entities/category.dart';

abstract class ICategoryRepo {
  Future<List<Category>> getAll();

  Future<void> deleteTag(Params params);

  Future<List<Tag>> getAllTags();

  Future<List<Tag>> getPublicTags();

  Future<List<Tag>> getShopTags();

  Future<Tag> addTag(Params params);

  Future<void> updateTag(Params params);
}
