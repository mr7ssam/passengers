import 'package:p_core/p_core.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/category_repo.dart';
import '../remote/data_sources/category_remote.dart';

class CategoryRepo extends ICategoryRepo {
  final CategoryRemote _categoryRemote;

  CategoryRepo(this._categoryRemote);
  @override
  Future<List<Category>> getCategories(Params params) async {
    final result = await _categoryRemote.getAllCategories(params);
    return result.map((e) => e.toModel()).toList();
  }

  @override
  Future<List<Tag>> getTags(Params params) async {
    final result = await _categoryRemote.getTags(params);
    return result.map((e) => e.toModel()).toList();
  }
}
