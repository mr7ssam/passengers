import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:p_design/p_design.dart';

part 'page_state.freezed.dart';

@freezed
class PageState<T> with _$PageState<T> {
  const factory PageState.init() = _init<T>;

  const factory PageState.loading() = _Lodaing<T>;

  const factory PageState.loaded({required T data}) = _Loaded<T>;

  const factory PageState.empty() = _Empty<T>;

  const factory PageState.error({required String error}) = _Error<T>;
}

extension PageStateEx on PageState {
  bool get isInit => maybeWhen(orElse: () => false, init: () => true);

  bool get isLoading => maybeWhen(orElse: () => false, loading: () => true);

  bool get isLoaded => maybeWhen(orElse: () => false, loaded: (_) => true);

  bool get isEmpty => maybeWhen(orElse: () => false, empty: () => true);

  bool get isError => maybeWhen(orElse: () => false, error: (_) => true);
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
  final Widget Function(String message)? error;

  @override
  Widget build(BuildContext context) {
    late final Widget next;
    result.maybeWhen(
      orElse: () => next = const SizedBox(),
      init: () => next = init?.call() ?? const SizedBox(),
      loading: () => next =
          Center(child: loading?.call() ?? const AppLoading()),
      loaded: (T data) => next = success(data),
      error: (message) =>
          next = Center(child: error?.call(message) ?? Text(message)),
    );
    return next;
  }
}
