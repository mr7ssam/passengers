import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/root/presentation/pages/get_started/get_started.dart';
import 'package:shop_app/app/root/presentation/root.dart';
import 'package:shop_app/app/user/domain/entities/user.dart';

import '../app/user/presentation/pages/complete_info/complete_info_land_screen.dart';
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
    final appState = context.read<AppMangerBloc>().state;

    final goingToHome = !(state.location.contains(RootScreen.path));
    if (goingToHome && appState.state == AppState.authenticated) {
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

    final goingToComplete =
        !(state.location.contains(CompleteInfoLandScreen.path));
    if (user?.accountStatus == AccountStatus.unCompleted) {
      return goingToComplete ? CompleteInfoLandScreen.path : null;
    }

    final goingToGetStarted = !(state.location.contains(GetStartedScreen.path));
    final wasInComplete = state.location.contains(CompleteInfoScreen.path);
    if (wasInComplete && goingToGetStarted) {
      return goingToGetStarted ? GetStartedScreen.path : null;
    } else if (!goingToGetStarted) {
      return null;
    }
    return RootScreen.path;
  }

  static AppRouter of(BuildContext context) {
    return Provider.of<AppRouter>(context, listen: false);
  }
}
