import 'package:p_core/p_core.dart';

import '../entities/category.dart';
import '../entities/tag.dart';

abstract class ICategoryRepo {
  Future<List<Category>> getCategories(Params params);
  Future<List<Tag>> getTags(Params params);
}
