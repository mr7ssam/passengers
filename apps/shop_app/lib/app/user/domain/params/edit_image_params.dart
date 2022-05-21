import 'dart:io';

import 'package:p_network/p_http_client.dart';
import 'package:shop_app/core/remote/params.dart';

class FileParams extends FormDataParams {
  final File file;

  FileParams(this.file);

  @override
  FormData toFromData() {
    return FormData.fromMap(toMap());
  }

  @override
  Map<String, dynamic> toMap() {
    return {'file': MultipartFile.fromFileSync(file.path)};
  }
}
