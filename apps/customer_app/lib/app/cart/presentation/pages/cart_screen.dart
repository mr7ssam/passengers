import 'package:customer_app/app/cart/domain/entities/cart.dart';
import 'package:customer_app/app/cart/domain/entities/cart_item.dart';
import 'package:customer_app/app/cart/presentation/pages/checkout_screen/checkout_screen.dart';
import 'package:customer_app/app/user/presentation/pages/address/add_address/add_address_screen.dart';
import 'package:customer_app/app/user/presentation/pages/address/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';

import '../../../root/presentation/pages/home/home.dart';
import '../../../user/domain/entities/address.dart';
import '../widgets/item_widget.dart';

class BotCartScreen<T extends ICartItem> extends StatelessWidget {
  const BotCartScreen({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart<T> cart;

  @override
  Widget build(BuildContext context) {
    if (cart.items.isEmpty) {
      return Center(
        child: SvgPicture.asset(
          EmptyState.noItemInCart,
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: cart.groups.values.map(
              (group) {
                final items = group.itemsList;
                return SliverStickyHeader(
                  header: Padding(
                    padding: PEdgeInsets.horizontal,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            group.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(PIcons.outline_calendar___edit),
                          label: const Text('Write note'),
                        ),
                      ],
                    ),
                  ),
                  sliver: SliverPadding(
                    padding: PEdgeInsets.horizontal,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = items[index];
                          return ItemWidget(item: item);
                        },
                        childCount: items.length,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        Consumer<Cart>(
          builder: (context, value, child) {
            return Padding(
              padding: PEdgeInsets.listView * 2,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const YouText.labelSmall(
                          'Total price',
                        ),
                        YouText.titleLarge(
                          NumberFormat.currency(
                            locale: 'ar_SY',
                            symbol: 'SYP',
                          ).format(value.totalPrice),
                          style: TextStyle(color: context.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _selectAddress(context);
                    },
                    child: const Icon(PIcons.outline_arrow___right_2),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _selectAddress(BuildContext context) {
    final control = FormControl<Address>(validators: [
      Validators.required,
    ]);
    showModalBottomSheet(
      context: context,
      builder: (c) {
        return BottomSheetWrapperWidget(
          title: 'Select Address',
          childrenPadding: PEdgeInsets.listView,
          children: [
            Consumer<MyAddressProvider>(
              builder: (context, value, child) {
                return StreamBuilder<List<Address>?>(
                  stream: value.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const AppLoading();
                    } else if (snapshot.hasError) {
                      return APIErrorWidget(
                        exception: snapshot.error! as AppException,
                      );
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const EmptyWidget(
                        path: EmptyState.noAddress,
                        title: 'No addresses yet!',
                      );
                    }
                    final addresses = snapshot.data!;
                    return ReactiveDropdownSearch<Address, Address>(
                      formControl: control,
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
                  },
                );
              },
            ),
            Space.vM1,
            Align(
              alignment: AlignmentDirectional.center,
              child: TextButton.icon(
                  onPressed: () {
                    context.pushNamed(AddAddressScreen.name);
                  },
                  label: const Text('Add address'),
                  icon: const Icon(PIcons.outline_plus)),
            ),
            Space.vM1,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<ControlStatus>(
                      stream: control.statusChanged,
                      builder: (context, snapshot) {
                        return FilledButton(
                          onPressed: snapshot.data == ControlStatus.valid
                              ? () {
                                  context.pushNamed(
                                    CheckoutScreen.name,
                                    extra: control.value,
                                  );
                                }
                              : null,
                          child: const Text('Next'),
                        );
                      }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
