import 'package:customer_app/common/const/const.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

import 'models/address_dto.dart';

class AddressRemote {
  final Dio _dio;

  AddressRemote(this._dio);

  Future<List<AddressDTO>> getAll() async {
    final response = await _dio.get(
      APIRoutes.address.getAll,
    );
    return throwAppException(
      () => (response.data as List).map((e) => AddressDTO.fromMap(e)).toList(),
    );
  }

  Future<AddressDTO> add(Params params) async {
    final response = await _dio.post(
      APIRoutes.address.add,
      data: params.toMap(),
    );
    return throwAppException(() => AddressDTO.fromMap(response.data));
  }

  Future<AddressDTO> update(Params params) async {
    final response = await _dio.post(
      APIRoutes.address.update,
      data: params.toMap(),
    );
    return throwAppException(() => AddressDTO.fromMap(response.data));
  }

  Future<void> delete(Params params) async {
    await _dio.delete(
      APIRoutes.address.delete,
      queryParameters: params.toMap(),
    );
  }
}
