import 'package:p_network/p_http_client.dart';
import 'package:shop_app/app/category/data/remote/models/category_dto.dart';
import 'package:shop_app/app/category/data/remote/models/tag_dto.dart';
import 'package:shop_app/common/const/const.dart';
import 'package:shop_app/core/remote/api_utils.dart';
import 'package:shop_app/core/remote/params.dart';

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

  Future<List<TagDTO>> getPublicTags() async {
    final response = await _dio.get(APIRoutes.tag.getPublic);
    return throwAppException(
      () => (response.data as List)
          .map(
            (e) => TagDTO.fromMap(e),
          )
          .toList(),
    );
  }

  Future<List<TagDTO>> getShopTags() async {
    final response = await _dio.get(
      APIRoutes.tag.getShopTags,
    );
    return throwAppException(
      () => (response.data as List)
          .map(
            (e) => TagDTO.fromMap(e),
          )
          .toList(),
    );
  }

  Future<TagDTO> addTag(Params params) async {
    final response =
        await _dio.post(APIRoutes.tag.addTag, data: params.toFormData());
    return throwAppException(
      () => TagDTO.fromMap(response.data),
    );
  }

  Future<void> deleteTag(Params params) async {
    await _dio.delete(APIRoutes.tag.delete, queryParameters: params.toMap());
  }

  Future<void> updateTag(Params params) async {
    await _dio.put(
      APIRoutes.tag.update,
      data: params.toFormData(),
    );
  }
}
