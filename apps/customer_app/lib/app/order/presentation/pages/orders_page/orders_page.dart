import 'package:customer_app/app/order/presentation/pages/orders_page/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../root/presentation/widgets/page_name_mixin.dart';
import '../../../domain/entities/order.dart';
import '../order_tracking/order_tracking_screen.dart';

class OrdersPage extends StatelessWidget with PageNameMixin {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  String get pageName => 'orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Builder(
        builder: (context) {
          final stream = context.watch<OrderProvider>().stream;
          return StreamBuilder<List<Order>>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: AppLoading(),
                );
              }
              final orders = snapshot.data!.reversed.toList();
              return RefreshIndicator(
                onRefresh: () async => context.read<OrderProvider>().start(),
                child: ListView.separated(
                  padding: PEdgeInsets.listView,
                  separatorBuilder: (context, index) => Space.vM1,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];

                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          OrderTrackingScreen.name,
                          params: {
                            'id': order.id,
                          },
                        );
                      },
                      child: Card(
                        child: RPadding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    YouText.bodySmall(
                                      'ID: ${order.serialNumber}',
                                    ),
                                    Container(
                                      width: 6.r,
                                      margin:
                                          REdgeInsets.symmetric(horizontal: 6),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: context.theme.dividerColor),
                                    ),
                                    YouText.bodySmall(
                                      timeago.format(order.dateCreated),
                                    ),
                                  ],
                                ),
                              ),
                              Space.vS2,
                              YouText.titleLarge(
                                order.status.label,
                              ),
                              Space.vS2,
                              YouText.labelMedium(
                                order.status.description,
                              ),
                              Space.vM1,
                              !order.status.isCanceledOrRefused()
                                  ? AnimatedSmoothIndicator(
                                      count: 4,
                                      effect: SlideEffect(
                                        spacing: 8.0.r,
                                        paintStyle: PaintingStyle.fill,
                                        dotColor: context.theme.dividerColor,
                                        radius: 4.0.r,
                                        dotWidth: 32.0.r,
                                        dotHeight: 8.r,
                                        strokeWidth: 1.5.r,
                                      ), // your preferred effect
                                      onDotClicked: (index) {},
                                      activeIndex: order.status.statusIndex - 1,
                                    )
                                  : const Text('Sad for you 😭'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
