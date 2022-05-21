import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:p_design/p_design.dart';
import 'package:p_network/p_http_client.dart';
import 'package:shop_app/app/product/presentation/pages/food_menu/food_menu_page.dart';

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

class PageStateBuilder<T> extends StatelessWidget {
  const PageStateBuilder({
    Key? key,
    required this.result,
    this.init,
    required this.success,
    this.loading,
    this.error,
  }) : super(key: key);

  final PageState<T> result;
  final Widget Function()? init;
  final Widget Function()? loading;
  final Widget Function(T data) success;
  final Widget Function(AppException message)? error;

  @override
  Widget build(BuildContext context) {
    late final Widget next;
    result.maybeWhen(
      orElse: () => next = const SizedBox(),
      init: () => next = init?.call() ?? const SizedBox(),
      loading: () =>
          next = Center(child: loading?.call() ?? const AppLoading()),
      loaded: (T data) => next = success(data),
      error: (e) => next = error?.call(e) ??
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: error?.call(e) ?? APIErrorWidget(exception: e),
                  ),
                ),
              );
            },
          ),
    );
    return next;
  }
}
