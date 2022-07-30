import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cart/domain/entities/cart.dart';
import '../../../../cart/presentation/pages/cart_screen.dart';

class CartScreen extends StatelessWidget {
  static const path = '/$subPath';
  static const subPath = 'cart';
  static const name = 'cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Cart'),
      ),
      body: BotCartScreen(
        cart: cart,
      ),
    );
  }
}
