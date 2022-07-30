import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';

import '../../app/cart/domain/entities/cart.dart';
import '../../app/root/presentation/pages/cart/cart_screen.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            context.pushNamed(CartScreen.name);
          },
          icon: Badge(
            showBadge: value.itemsList.isNotEmpty,
            badgeColor: Colors.redAccent,
            position: BadgePosition.topEnd(),
            child: const Icon(
              PIcons.outline_bag,
            ),
          ),
        );
      },
    );
  }
}
