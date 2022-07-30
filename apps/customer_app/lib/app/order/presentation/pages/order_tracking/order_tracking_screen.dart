import 'package:customer_app/app/order/domain/entities/order_traking_details.dart';
import 'package:customer_app/app/order/presentation/pages/order_details/order_details.dart';
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

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

  static const path = 'order/:id';
  static const name = 'order_tracking';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
        create: (context) => OrderTrackingProvider(
          si(),
          state.params['id'] as String,
        )..started(),
        child: const OrderTrackingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderTrackingProvider>().state;
    final isLoading = state.isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: !isLoading ? context.colorScheme.primary : null,
        iconTheme: !isLoading
            ? IconThemeData(color: context.colorScheme.onPrimary)
            : null,
      ),
      body: PageStateBuilder<OrderTrackingDetails>(
        result: state,
        success: (OrderTrackingDetails order) {
          return PlayAnimation<Offset>(
            duration: const Duration(milliseconds: 300),
            key: ValueKey(order.id),
            curve: Curves.easeOutCirc,
            tween: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: const Offset(0, 0),
            ),
            builder: (context, child, animation) => FractionalTranslation(
              translation: animation,
              child: child,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: Colors.white,
                          displayColor: Colors.white.withOpacity(0.8),
                        ),
                    brightness: Brightness.dark,
                  ),
                  child: Container(
                    padding: PEdgeInsets.listView,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Column(
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
                                        margin: REdgeInsets.symmetric(
                                            horizontal: 6),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: context
                                              .theme.colorScheme.onPrimary,
                                        ),
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
                                AnimatedSmoothIndicator(
                                  count: 4,
                                  effect: SlideEffect(
                                    spacing: 8.0.r,
                                    paintStyle: PaintingStyle.fill,
                                    dotColor: context.colorScheme.onPrimary,
                                    activeDotColor:
                                        context.colorScheme.secondary,
                                    radius: 4.0.r,
                                    dotWidth: 32.0.r,
                                    dotHeight: 8.r,
                                    strokeWidth: 1.5.r,
                                  ), // your preferred effect
                                  onDotClicked: (index) {},
                                  activeIndex: order.status.statusIndex - 1,
                                ),
                                Space.vM3,
                              ],
                            ),
                            Space.hM2,
                            Flexible(
                              child: AnimateWidgetOrderStatus(
                                child: SvgPicture.asset(
                                  order.status.svgPath,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: PEdgeInsets.listView,
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) => SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1,
                          child: child,
                        ),
                        child: order.isOnWay()
                            ? Column(
                                children: [
                                  CustomListTile(
                                    textWidget: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        YouText.bodySmall('Driver your order'),
                                        YouText.labelLarge(
                                            'Hussmov shikh al SABA'),
                                      ],
                                    ),
                                    icon: CircleAvatar(
                                        backgroundColor:
                                            context.colorScheme.primary,
                                        child:
                                            const Icon(PIcons.outline_profile)),
                                    trilling: const Icon(PIcons.outline_phone,
                                        color: Colors.green),
                                    onTap: () {},
                                  ),
                                  Space.vM1,
                                  CustomListTile(
                                    text: 'Track your order',
                                    icon:
                                        const Icon(PIcons.outline_pin_location),
                                    onTap: () {},
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      Card(
                        child: Padding(
                          padding: PEdgeInsets.listView,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const CustomTitle.small(
                                        label: Text('Pickup point'),
                                        icon: Icon(
                                          PIcons.outline_shop,
                                        ),
                                      ),
                                      Space.vS2,
                                      YouText.labelLarge(order.shopName),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const CustomTitle.small(
                                        label: Text('Pick off'),
                                        icon: Icon(
                                          PIcons.outline_pin_location,
                                        ),
                                      ),
                                      Space.vS2,
                                      YouText.labelLarge(order.addressTitle),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                height: LayoutConstrains.m3.h * 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTitle.small(
                                    label: Text(prettyDuration(order.time)),
                                    icon: const Icon(
                                      PIcons.outline_time_arrival,
                                    ),
                                  ),
                                  CustomTitle.small(
                                    label: Text(
                                      NumberFormat.currency(
                                        symbol: ' SYP ',
                                        decimalDigits: 0,
                                      ).format(
                                        order.subTotal,
                                      ),
                                    ),
                                    icon: const Icon(
                                      PIcons.outline_bag_money,
                                    ),
                                  ),
                                  CustomTitle.small(
                                    label: Text('${order.distance} KM'),
                                    icon: const Icon(
                                      PIcons.outline_pin_location,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomListTile(
                        text: 'Show more details',
                        icon: Icon(PIcons.outline_leg_chicken),
                        onTap: () {
                          context.pushNamed(OrderDetailsScreen.name, params: {
                            'id': order.id,
                          });
                        },
                      )
                    ].superJoin(Space.vM1).toList(),
                  ),
                )
              ],
            ),
          );
        },
        loading: () {
          return Center(
              child: MirrorAnimation<Color?>(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
            tween: ColorTween(
              begin: context.colorScheme.primary,
              end: context.colorScheme.background,
            ), // define tween
            builder: (_, __, color) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    PIcons.outline_motorcycle,
                    size: 42.r,
                    color: color,
                  ),
                  RSizedBox(
                    width: 32,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const LinearProgressIndicator()),
                  ),
                ],
              );
            },
          ));
        },
      ),
    );
  }
}

class AnimateWidgetOrderStatus extends StatelessWidget {
  final Widget child;

  const AnimateWidgetOrderStatus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      switchOutCurve: Curves.elasticInOut,
      switchInCurve: Curves.elasticInOut,
      child: child,
    );
  }
}
