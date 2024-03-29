import 'package:flutter/material.dart' show BuildContext, FocusManager;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/root/presentation/pages/get_started/get_started.dart';
import 'package:shop_app/app/root/presentation/root.dart';
import 'package:shop_app/app/user/domain/entities/user.dart';

import '../app/user/presentation/pages/complete_info/complete_info_land_screen.dart';
import '../app_manger/bloc/app_manger_bloc.dart';
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
        GoRoute(
          path: FoodListCategoriesSettings.path,
          name: FoodListCategoriesSettings.name,
          pageBuilder: FoodListCategoriesSettings.pageBuilder,
        ),
        GoRoute(
          path: WorkingDaysSettings.path,
          name: WorkingDaysSettings.name,
          pageBuilder: WorkingDaysSettings.pageBuilder,
        ),
        GoRoute(
          path: AddProductScreen.path,
          name: AddProductScreen.name,
          pageBuilder: AddProductScreen.pageBuilder,
        ),
        GoRoute(
            path: ProductDetailsScreen.path,
            name: ProductDetailsScreen.name,
            pageBuilder: ProductDetailsScreen.pageBuilder,
            routes: [
              GoRoute(
                path: AddProductScreen.editPath,
                name: AddProductScreen.editName,
                pageBuilder: AddProductScreen.pageBuilder,
              ),
            ])
      ],
    ),
    GoRoute(
      path: CompleteInfoLandScreen.path,
      name: CompleteInfoLandScreen.name,
      pageBuilder: CompleteInfoLandScreen.pageBuilder,
      routes: [
        GoRoute(
          path: CompleteInfoScreen.path,
          name: CompleteInfoScreen.name,
          pageBuilder: CompleteInfoScreen.pageBuilder,
        )
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
    final user = appState.user;

    // check if user is complete info
    if (user?.accountStatus == AccountStatus.unCompleted) {
      final goingToComplete =
          !(state.location.contains(CompleteInfoLandScreen.path));
      return goingToComplete ? CompleteInfoLandScreen.path : null;
    }

    // check if user is first time user
    final wasInComplete = state.location.contains(CompleteInfoScreen.path);
    final goingToGetStarted = !(state.location.contains(GetStartedScreen.path));
    if (wasInComplete || !goingToGetStarted) {
      return goingToGetStarted ? GetStartedScreen.path : null;
    }

    // user is authenticated and has completed info
    final goingToHome = !(state.location.contains(RootScreen.path));
    return goingToHome ? RootScreen.path : null;
  }

  static AppRouter of(BuildContext context) {
    return Provider.of<AppRouter>(context, listen: false);
  }
}
