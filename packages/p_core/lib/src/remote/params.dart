import 'dart:async';

import 'package:dio/dio.dart';

abstract class IMap {
  const IMap();

  Map<String, dynamic> toMap();
}

abstract class Params implements IMap {
  final CancelToken cancelToken = CancelToken();
}

class ParamsWrapper extends Params {
  final Map<String, dynamic> params;

  ParamsWrapper(this.params);

  @override
  Map<String, dynamic> toMap() => params;
}

abstract class FormDataParams extends Params {
  FutureOr<FormData> toFromData();
}

class NoParams extends Params  {
  @override
  Map<String, dynamic> toMap() => {};
}

class PagingParams extends Params {
  final int page;
  final int pageSize;

  PagingParams({
    this.page = 1,
    this.pageSize = 20,
  });

  @override
  Map<String, dynamic> toMap() => {
        'pageNumber': page,
        'pageSize': pageSize,
      };
}

extension ParamsEx on Params {
  FormData toFormData() {
    return FormData.fromMap(toMap());
  }
}
