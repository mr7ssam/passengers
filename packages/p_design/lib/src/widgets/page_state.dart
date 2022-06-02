import 'package:flutter/material.dart';
import 'package:p_core/p_core.dart';

import 'api_error_widget.dart';
import 'app_loading.dart';

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
