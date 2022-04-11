import 'package:p_network/p_http_client.dart';
import 'package:shop_app/common/const/const.dart';
import 'package:shop_app/core/api_utils.dart';
import 'package:shop_app/features/category/data/remote/models/category_dto.dart';
import 'package:shop_app/features/category/data/remote/models/tag_dto.dart';

class CategoryRemote {
  final Dio _dio;

  CategoryRemote(this._dio);

  Future<List<CategoryDto>> getAllCategory() async {
    final response = await _dio.get(APIRoutes.category.getAllCategories);
    return throwAppException(
      () => (response.data as List)
          .map(
            (e) => CategoryDto.fromMap(e),
          )
          .toList(),
    );
  }

  Future<List<TagDTO>> getAllTags() async {
    final response = await _dio.get(APIRoutes.tag.getAllTags);
    return throwAppException(
      () => (response.data as List)
          .map(
            (e) => TagDTO.fromMap(e),
          )
          .toList(),
    );
  }
}
