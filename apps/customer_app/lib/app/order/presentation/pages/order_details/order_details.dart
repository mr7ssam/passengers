import 'package:customer_app/app/order/domain/entities/order_traking_details.dart';
import 'package:customer_app/app/order/presentation/pages/order_details/provider.dart';
import 'package:customer_app/app/order/presentation/pages/order_tracking/provider.dart';
import 'package:duration/duration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../injection/service_locator.dart';
import '../../../domain/entities/order_details.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  static const path = ':id/details';
  static const name = 'order_details';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
        create: (context) => OrderDetailsProvider(
          si(),
          state.params['id'] as String,
        )..fetch(),
        child: const OrderDetailsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderDetailsProvider>().state;
    final isLoading = state.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: PageStateBuilder<OrderDetails>(
        result: state,
        success: (OrderDetails order) {
          final products = order.products;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: PEdgeInsets.listView,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return Row(
                      children: [
                        RSizedBox.square(
                          dimension: 64,
                          child: ImageAvatar(
                            imagePath: product.imagePath,
                            replacement: const Icon(PIcons.outline_leg_chicken),
                          ),
                        ),
                        Space.hM1,
                        Flexible(
                          child: RPadding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YouText.labelLarge(
                                  product.name,
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                                Space.vS2,
                                YouText.labelMedium(product.price.toString()),
                              ],
                            ),
                          ),
                        ),
                        Space.hM1,
                        YouText.labelLarge('x${product.count}'),
                      ],
                    );
                  },
                  itemCount: products.length,
                ),
              ),
              RPadding(
                padding: PEdgeInsets.listView,
                child: Column(
                  children: [
                    const CustomTitle(label: YouText.labelLarge('Summary')),
                    const Divider(),
                    Column(
                      children: [
                        Row(
                          children: [
                            YouText.bodyLarge('Total',
                                style: TextStyle(
                                    color: context.colorScheme.primary)),
                            const Spacer(),
                            YouText.bodyLarge(
                              order.subTotal.toString(),
                              style: TextStyle(
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ],
                        )
                      ].toList(),
                    ),
                  ],
                ),
              ),
              Space.vM3,
            ],
          );
        },
      ),
    );
  }
}
