import 'package:customer_app/app/cart/application/facade.dart';
import 'package:customer_app/injection/features.dart';
import 'package:customer_app/injection/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';

import '../../domain/entities/cart.dart';
import '../../domain/entities/checkout.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
    required this.checkout,
  }) : super(key: key);

  final Checkout checkout;

  static const path = 'payment';
  static const name = 'payment_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    final checkout = state.extra as Checkout;
    return MaterialPage<void>(
      key: state.pageKey,
      child: PaymentScreen(
        checkout: checkout,
      ),
    );
  }

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: PEdgeInsets.listView,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CheckboxListTile(
                    value: true,
                    onChanged: (_) {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(PRadius.container),
                        side: BorderSide(color: context.colorScheme.primary)),
                    title: Row(
                      children: [
                        Stack(
                          children: [
                            Icon(
                              PIcons.outline_wallet,
                              color: context.colorScheme.primary,
                              size: 28.r,
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text('Cash on delivery'),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: PEdgeInsets.listView,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Hero(
                        tag: 'total', child: YouText.labelMedium('Total:')),
                    const Spacer(),
                    Hero(
                      tag: 'total-value',
                      child: YouText.labelLarge(
                        'SYP ${widget.checkout.total.toStringAsFixed(2)}',
                      ),
                    ),
                  ],
                ),
                Space.vM1,
                Hero(
                  tag: 'Payment',
                  child: FilledButton(
                    child: const Text('Pay'),
                    onPressed: () async {
                      await _placeOrder(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _placeOrder(BuildContext context) async {
    EasyLoading.show();
    final result = await si<CartFacade>().addOrder(widget.checkout);
    EasyLoading.dismiss();
    if (result.isSuccess && mounted) {
      context.read<Cart>().reset();
      EasyLoading.showSuccess('Order placed successfully');
      context.go('/orders');
    } else {
      EasyLoading.showError(result.exception.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }
}
