import 'dart:io';

import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

class ImageParams extends FormDataParams {
  final File file;

  ImageParams(this.file);

  @override
  Future<FormData> toFromData() async {
    return FormData.fromMap({
      'file': MultipartFile.fromFileSync(
        (await compressImage(file))!.path,
      )
    });
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
