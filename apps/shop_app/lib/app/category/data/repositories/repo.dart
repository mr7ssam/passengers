import 'package:p_core/p_core.dart';
import 'package:shop_app/app/category/data/remote/remote.dart';
import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/app/category/domain/repositories/repo.dart';

class CategoryRepo implements ICategoryRepo {
  final CategoryRemote _categoryRemote;

  CategoryRepo(this._categoryRemote);

  @override
  Future<List<Category>> getAll() {
    return _categoryRemote
        .getAllCategory()
        .then((value) => value.map((e) => e.toModel()).toList());
  }

  @override
  Future<List<Tag>> getPublicTags() {
    return _categoryRemote
        .getPublicTags()
        .then((value) => value.map((e) => e.toModel()).toList());
  }

  @override
  Future<List<Tag>> getShopTags() {
    return _categoryRemote
        .getShopTags()
        .then((value) => value.map((e) => e.toModel()).toList());
  }

  @override
  Future<Tag> addTag(Params params) {
    return _categoryRemote.addTag(params).then(
          (value) => value.toModel(),
        );
  }

  @override
  Future<void> deleteTag(Params params) {
    return _categoryRemote.deleteTag(params);
  }

  @override
  Future<void> updateTag(Params params) {
    return _categoryRemote.updateTag(params);
  }
}
