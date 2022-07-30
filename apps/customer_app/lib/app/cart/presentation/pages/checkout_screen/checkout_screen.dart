import 'package:customer_app/app/cart/domain/entities/cart.dart';
import 'package:customer_app/app/cart/presentation/pages/checkout_screen/bloc/checkout_bloc.dart';
import 'package:customer_app/app/cart/presentation/pages/payment_screen.dart';
import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:customer_app/injection/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';

import '../../../../user/application/facade.dart';
import '../../../domain/entities/checkout.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  static const path = 'checkout';
  static const name = 'checkout-screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    final selectedAddress = state.extra as Address;
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<CheckoutBloc>(
          create: (context) {
            return CheckoutBloc(CheckoutState(address: selectedAddress), si())
              ..add(CheckoutStarted(context.read<Cart>()))
              ..add(CheckedOut());
          },
          child: const CheckoutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: PEdgeInsets.listView,
              children: const [
                CustomTitle(
                  label: Text('Address details'),
                ),
                Space.vS2,
                SelectAddressWidget(),
                Space.vXL3,
                CustomTitle(label: Text('Summary')),
                Divider(),
                OrderSummary(),
              ],
            ),
          ),
          const PaymentWidget()
        ],
      ),
    );
  }
}

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkout = context.select<CheckoutBloc, PageState<Checkout>>(
        (value) => value.state.checkout);
    return Padding(
      padding: PEdgeInsets.listView,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Hero(
                  tag: 'total',
                  child: YouText.labelSmall(
                    'Total price',
                  ),
                ),
                checkout.isLoaded
                    ? Hero(
                        tag: 'total-value',
                        child: YouText.titleLarge(
                          NumberFormat.currency(
                            locale: 'ar_SY',
                            symbol: 'SYP',
                          ).format(checkout.data.total),
                          style: TextStyle(color: context.colorScheme.primary),
                        ),
                      )
                    : const YouText.titleLarge(
                        'Loading...',
                      ),
              ],
            ),
          ),
          Hero(
            tag: 'Payment',
            child: FilledButton(
              onPressed: checkout.isLoaded
                  ? () {
                      context.pushNamed(PaymentScreen.name,
                          extra: checkout.data);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Payment'),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkout = context.select<CheckoutBloc, PageState<Checkout>>(
        (value) => value.state.checkout);
    return PageStateBuilder<Checkout>(
      result: checkout,
      success: (data) {
        return Column(
          children: [
            Row(
              children: [
                const Text('Expected arrival time'),
                const Spacer(),
                Text('${data.expectedArrivalTime} min'),
              ],
            ),
            const Divider(),
            ...data.items.map((e) => Row(
                  children: [
                    Text(e.shopName),
                    const Spacer(),
                    Text(e.total.toString()),
                  ],
                )),
            const Divider(),
            Row(
              children: [
                const Text('Total'),
                const Spacer(),
                Text(data.total.toString()),
              ],
            )
          ].toList(),
        );
      },
    );
  }
}

class SelectAddressWidget extends StatelessWidget {
  const SelectAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addresses = si<UserFacade>().addresses;
    return ReactiveDropdownSearch<Address, Address>(
      formControl: context.read<CheckoutBloc>().addressControl,
      items: addresses,
      itemAsString: (s) => s.title,
      popupProps: const PopupProps.modalBottomSheet(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
          hintText: 'Search...',
          suffixIcon: Icon(PIcons.outline_search),
        )),
      ),
      decoration: const InputDecoration(
        hintText: 'Select your address',
      ),
    );
  }
}
