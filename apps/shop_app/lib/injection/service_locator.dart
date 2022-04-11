import 'package:get_it/get_it.dart';

import 'features.dart';

final si = GetIt.I;

Future<void> inject() async {
  await common();
  await user();
  await category();
}
