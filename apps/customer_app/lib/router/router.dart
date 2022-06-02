import 'package:flutter/material.dart' show BuildContext, FocusManager;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app/root/presentation/pages/get_started/get_started.dart';
import '../core/app_manger/bloc/app_manger_bloc.dart';
import 'routes.dart';

class AppRouter {
  AppRouter({
    required this.context,
  }) {
    goRouter = GoRouter(
      routes: _routes,
      initialLocation: SplashScreen.path,
      redirect: (state) => _rootRedirect(context, state),
      refreshListenable:
          GoRouterRefreshStream(context.read<AppMangerBloc>().stream),
    );
  }

  final BuildContext context;

  late final GoRouter goRouter;

  late final _routes = [
    GoRoute(
      path: SplashScreen.path,
      name: SplashScreen.name,
      pageBuilder: SplashScreen.pageBuilder,
    ),
    GoRoute(
      path: RootScreen.path,
      name: RootScreen.name,
      pageBuilder: RootScreen.pageBuilder,
      routes: [
        GoRoute(
          path: SettingsScreen.path,
          name: SettingsScreen.name,
          pageBuilder: SettingsScreen.pageBuilder,
          routes: [
            GoRoute(
              path: UserInfoScreen.path,
              name: UserInfoScreen.name,
              pageBuilder: UserInfoScreen.pageBuilder,
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: GetStartedScreen.path,
      name: GetStartedScreen.name,
      pageBuilder: GetStartedScreen.pageBuilder,
    ),
    GoRoute(
      path: WelcomeScreen.path,
      name: WelcomeScreen.name,
      pageBuilder: WelcomeScreen.pageBuilder,
      routes: [
        GoRoute(
          path: LoginScreen.path,
          name: LoginScreen.name,
          pageBuilder: LoginScreen.pageBuilder,
        ),
        GoRoute(
          path: SignUpScreen.path,
          name: SignUpScreen.name,
          pageBuilder: SignUpScreen.pageBuilder,
        ),
      ],
    ),
  ];

  _rootRedirect(BuildContext context, GoRouterState state) {
    FocusManager.instance.primaryFocus?.unfocus();
    final appState = context.read<AppMangerBloc>().state;

    if (appState.state == AppState.authenticated) {
      return _userStatusRedirect(context, state, appState);
    }

    final goingToWelcome = !(state.location.contains(WelcomeScreen.path));
    if (goingToWelcome && appState.state == AppState.unAuthenticated) {
      return WelcomeScreen.path;
    }

    return null;
  }

  String? _userStatusRedirect(
    BuildContext context,
    GoRouterState state,
    AppMangerState appState,
  ) {
    final goingToHome = !(state.location.contains(RootScreen.path));
    return goingToHome ? RootScreen.path : null;
  }

  static AppRouter of(BuildContext context) {
    return Provider.of<AppRouter>(context, listen: false);
  }
}
