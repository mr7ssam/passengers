import 'package:customer_app/common/const/const.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

import '../models/category_dto.dart';
import '../models/tag_dto.dart';

class CategoryRemote {
  final Dio _dio;

  CategoryRemote(this._dio);

  Future<List<TagDTO>> getTags(Params params) async {
    return throwAppException(
      () => _dio
          .get(
            APIRoutes.category.getShopTags,
            queryParameters: params.toMap(),
          )
          .then(
            (value) =>
                (value.data as List).map((e) => TagDTO.fromMap(e)).toList(),
          ),
    );
  }

  Future<List<CategoryDTO>> getAllCategories(Params params) async {
    return throwAppException(
      () => _dio
          .get(
            APIRoutes.category.getAllCategories,
            queryParameters: params.toMap(),
          )
          .then(
            (value) => (value.data as List)
                .map((e) => CategoryDTO.fromMap(e))
                .toList(),
          ),
    );
  }
}
