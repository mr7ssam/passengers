import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/order/presentation/pages/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../domain/entities/order.dart';
import '../../domain/entities/shop_orders.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageStateBuilder<Key>(
      result: context
          .select<OrdersProvider, PageState<Key>>((value) => value.pageState),
      success: (key) => DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: context.colorScheme.onSurface,
              tabs: const [
                Tab(text: 'Received'),
                Tab(text: 'Ready'),
              ],
            ),
            Expanded(
              child: TabBarView(
                key: key,
                children: const [
                  _ReceivedOrders(),
                  _ReadyOrders(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceivedOrders extends StatelessWidget {
  const _ReceivedOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = context.select<OrdersProvider, ShopOrders>(
      (value) => value.shopOrders,
    );
    return _ListOrderWidget(
      orders: orders.received,
    );
  }
}

class _ReadyOrders extends StatelessWidget {
  const _ReadyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = context.select<OrdersProvider, ShopOrders>(
      (value) => value.shopOrders,
    );

    return _ListOrderWidget(
      orders: orders.ready,
      ready: true,
    );
  }
}

class _ListOrderWidget extends StatelessWidget {
  const _ListOrderWidget({
    Key? key,
    required this.orders,
    this.ready = false,
  }) : super(key: key);
  final List<Order> orders;
  final bool ready;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<OrdersProvider>().fetch(),
      child: orders.isEmpty
          ? SizedBox(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 0.9.sh,
                  child: Center(
                    child: SvgPicture.asset(
                      EmptyState.noOrders,
                    ),
                  ),
                ),
              ),
            )
          : AnimatedList(
              initialItemCount: orders.length,
              padding: PEdgeInsets.listView,
              itemBuilder: (context, index, animation) {
                final order = orders[index];
                return OrderListTile(
                  index: index,
                  order: order,
                  ready: ready,
                  animation: animation,
                );
              },
            ),
    );
  }
}

class OrderListTile extends StatefulWidget {
  const OrderListTile({
    Key? key,
    required this.index,
    required this.order,
    required this.animation,
    required this.ready,
  }) : super(key: key);

  final int index;
  final Order order;
  final bool ready;
  final Animation<double> animation;

  @override
  State<OrderListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {
  final _loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
              .animate(widget.animation),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: PEdgeInsets.card,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      YouText.bodySmall(
                        'ID: ${widget.order.serialNumber}',
                      ),
                      Container(
                        width: 6.r,
                        margin: REdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.dividerColor),
                      ),
                      YouText.bodySmall(
                        timeago.format(widget.order.dateCreated),
                      ),
                      const Spacer(),
                      if (!widget.ready)
                        ValueListenableBuilder<bool>(
                          valueListenable: _loading,
                          builder: (_, value, __) => !value
                              ? TextButton.icon(
                                  onPressed: () async {
                                    _loading.value = true;
                                    await context
                                        .read<OrdersProvider>()
                                        .markReady(widget.order, context,
                                            widget.index);
                                    _loading.value = false;
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                  ),
                                  icon: const Icon(PIcons.outline_check),
                                  label: const Text('Ready'))
                              : const AppLoading(),
                        )
                    ],
                  ),
                ),
                Space.vM1,
                ...widget.order.products
                    .map<Widget>((e) => Row(
                          children: [
                            YouText.labelMedium(e.name),
                            const Spacer(),
                            YouText.labelMedium('×${e.count}'),
                          ],
                        ))
                    .superJoin(Space.vS3)
                    .toList(),
                Divider(height: LayoutConstrains.m3.h),
                Row(
                  children: [
                    const YouText.labelLarge(
                      'Total Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    YouText.bodyLarge(
                      NumberFormat.currency(decimalDigits: 0, symbol: 'SYP')
                          .format(widget.order.totalPrice),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
