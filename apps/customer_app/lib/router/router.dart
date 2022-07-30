import 'package:customer_app/app/cart/presentation/pages/checkout_screen/checkout_screen.dart';
import 'package:customer_app/app/order/domain/entities/order_traking_details.dart';
import 'package:customer_app/app/order/presentation/pages/order_tracking/order_tracking_screen.dart';
import 'package:customer_app/app/user/presentation/pages/address/add_address/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';

import '../app/cart/presentation/pages/payment_screen.dart';
import '../app/order/presentation/pages/order_details/order_details.dart';
import '../app/products/presentation/pages/product_details/product_details_screen.dart';
import '../app/root/presentation/pages/cart/cart_screen.dart';
import '../app/user/presentation/pages/address/my_addresses_screen.dart';
import '../core/app_manger/bloc/app_manger_bloc.dart';
import 'routes.dart';

class AppRouter {
  AppRouter({
    required this.context,
  }) {
    goRouter = GoRouter(
      routes: _routes,
      debugLogDiagnostics: true,
      initialLocation: SplashScreen.path,
      redirect: (state) => _rootRedirect(context, state),
      navigatorBuilder: (context, state, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(child: child),
                YouText.labelSmall(state.location),
              ],
            ),
          ),
        );
      },
      refreshListenable:
          GoRouterRefreshStream(context.read<AppMangerBloc>().stream),
    );
  }

  final BuildContext context;

  late final GoRouter goRouter;

  late final _routes = [
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
    GoRoute(
      path: SplashScreen.path,
      name: SplashScreen.name,
      pageBuilder: SplashScreen.pageBuilder,
    ),
    GoRoute(
      path: AddAddressScreen.path,
      name: AddAddressScreen.name,
      pageBuilder: AddAddressScreen.pageBuilder,
    ),
    GoRoute(
      path: '/',
      redirect: (_) => '/home',
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
          path: OrderTrackingScreen.path,
          name: OrderTrackingScreen.name,
          pageBuilder: OrderTrackingScreen.pageBuilder,
        ),
        GoRoute(
          path: OrderDetailsScreen.path,
          name: OrderDetailsScreen.name,
          pageBuilder: OrderDetailsScreen.pageBuilder,
        ),
        GoRoute(
          path: ProductDetailsScreen.path,
          name: ProductDetailsScreen.name,
          pageBuilder: ProductDetailsScreen.pageBuilder,
        ),
        GoRoute(
          path: MyAddressScreen.path,
          name: MyAddressScreen.name,
          pageBuilder: MyAddressScreen.pageBuilder,
        ),
        GoRoute(
          path: CartScreen.subPath,
          name: CartScreen.name,
          pageBuilder: CartScreen.pageBuilder,
          routes: [
            GoRoute(
              path: CheckoutScreen.path,
              name: CheckoutScreen.name,
              pageBuilder: CheckoutScreen.pageBuilder,
              routes: [
                GoRoute(
                  path: PaymentScreen.path,
                  name: PaymentScreen.name,
                  pageBuilder: PaymentScreen.pageBuilder,
                )
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: RootScreen.path,
      name: RootScreen.name,
      pageBuilder: RootScreen.pageBuilder,
    ),
  ];

  AppState? _preState;

  _rootRedirect(BuildContext context, GoRouterState state) {
    FocusManager.instance.primaryFocus?.unfocus();
    final appState = context.read<AppMangerBloc>().state;
    if (_preState == appState.state) {
      return null;
    }
    _preState = appState.state;

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
    final goingToHome = !(state.subloc == '/');
    return goingToHome ? '/' : null;
  }

  static AppRouter of(BuildContext context) {
    return Provider.of<AppRouter>(context, listen: false);
  }
}
