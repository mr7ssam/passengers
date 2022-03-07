import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class AppRouter extends GoRouter {
  AppRouter({
    required this.context,
  }) : super(
          routes: _routes(context),
        );

  final BuildContext context;

  static List<GoRoute> _routes(BuildContext context) {
    return [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        pageBuilder: SplashScreen.pageBuilder,
      ),
    ];
  }
}
