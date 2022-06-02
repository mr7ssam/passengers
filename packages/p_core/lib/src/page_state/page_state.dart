import 'package:freezed_annotation/freezed_annotation.dart';

import '../exceptions/exceptions.dart';

part 'page_state.freezed.dart';

@freezed
class PageState<T> with _$PageState<T> {
  const factory PageState.init() = _init<T>;

  const factory PageState.loading() = _Lodaing<T>;

  const factory PageState.loaded({required T data}) = _Loaded<T>;

  const factory PageState.empty() = _Empty<T>;

  const factory PageState.error({required AppException exception}) = _Error<T>;
}

extension PageStateEx<T> on PageState<T> {
  bool get isLoading => this is _Lodaing;

  bool get isLoaded => this is _Loaded;

  bool get isEmpty => this is _Empty;

  bool get isError => this is _Error;

  _Lodaing<T> get loading => this as _Lodaing<T>;

  _Loaded<T> get loaded => this as _Loaded<T>;

  T get data => (this as _Loaded).data;

  String get error => (this as _Error).error;
}
