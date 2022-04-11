import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class TStorage<T> {
  /// Returns the stored data.
  T? read();

  /// Saves the provided [value] asynchronously.
  FutureOr<void> write(T? value);

  /// Deletes the stored data asynchronously.
  FutureOr<void> delete();
}

mixin TStorageStreamMixin<T> on TStorage<T> {
  T? value;

  final StreamController<T?> _controller = StreamController<T?>.broadcast();

  Stream<T?> get stream async* {
    value = read();
    yield value;
    yield* _controller.stream;
  }

  @override
  @mustCallSuper
  FutureOr<void> write(T? value) {
    _controller.add(value);
  }

  @override
  @mustCallSuper
  FutureOr<void> delete() {
    _controller.add(null);
  }
}
