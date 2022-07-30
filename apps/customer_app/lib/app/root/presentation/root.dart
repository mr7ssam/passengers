import 'dart:math';

import 'package:customer_app/app/root/presentation/pages/comming.dart';
import 'package:customer_app/app/user/presentation/pages/address/my_addresses_screen.dart';
import 'package:customer_app/common/widgets/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:collection/collection.dart';
import '../../../injection/service_locator.dart';
import '../../order/presentation/pages/orders_page/order_provider.dart';
import '../../order/presentation/pages/orders_page/orders_page.dart';
import '../../products/presentation/pages/food_list_page/food_list_screen.dart';
import '../../user/domain/entities/address.dart';
import '../../user/presentation/pages/address/provider.dart';
import 'pages/home/home.dart';
import 'widgets/drawer.dart';
import 'widgets/page_name_mixin.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({
    Key? key,
    required this.pageName,
  }) : super(key: key);
  static const path = '/:pageName';
  static const name = 'root_screen';

  final String? pageName;

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<OrderProvider>(
            create: (context) => OrderProvider(si())..start(),
          )
        ],
        child: RootScreen(
          pageName: state.params['pageName'],
        ),
      ),
    );
  }

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late final PageController _controller;
  late final List<PageNameMixin> _pages;

  @override
  void initState() {
    const coming = ComingPage();
    _pages = const [
      HomePage(),
      FoodListPage(),
      coming,
      coming,
      OrdersPage(),
    ];
    _controller = PageController(initialPage: selectedIndex);
    super.initState();
  }

  int get selectedIndex => _pages.indexWhere(
        (element) => element.pageName == widget.pageName,
      );

  @override
  void didUpdateWidget(RootScreen oldWidget) {
    _controller.jumpToPage(selectedIndex);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Builder(
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                backgroundColor: Theme.of(context).cardColor,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  context.goNamed(
                    RootScreen.name,
                    params: {
                      'pageName': _pages[index].pageName,
                    },
                  );
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(PIcons.outline_home),
                    selectedIcon: Icon(PIcons.fill_home),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(PIcons.outline_leg_chicken),
                    selectedIcon: Icon(PIcons.fill_leg_chicken),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(PIcons.outline_fire),
                    selectedIcon: Icon(PIcons.fill_offer),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(PIcons.outline_shop),
                    selectedIcon: Icon(PIcons.fill_shop),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(PIcons.outline_bell_ring),
                    selectedIcon: Icon(PIcons.fill_bell_ring),
                    label: '',
                  ),
                ]
                    .mapIndexed((index, element) => NavigationPlayAnimation(
                        index: index,
                        selectedIndex: selectedIndex,
                        child: element))
                    .toList(),
              ),
            ),
          );
        },
      ),
      drawer: const AppDrawer(),
      appBar: const _AppBar(),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}

class NavigationPlayAnimation extends StatelessWidget {
  const NavigationPlayAnimation({
    Key? key,
    required this.index,
    required this.selectedIndex,
    required this.child,
  }) : super(key: key);
  final int index;
  final int selectedIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      duration: const Duration(milliseconds: 450),
      tween: Tween(begin: 0, end: 1.0),
      delay: Duration(milliseconds: (index + 1) * 200),
      curve: Curves.elasticInOut,
      builder: (context, child, value) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: PlayAnimation<double>(
        key: ValueKey(selectedIndex == index),
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 0.5, end: 1.0),
        curve: Curves.elasticInOut,
        builder: (context, _, value) {
          return Opacity(
            opacity: min(value, 1.0),
            child: Transform.scale(
              scale: value,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSize {
  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Consumer<MyAddressProvider>(
        builder: (context, value, child) {
          final stream = value.selectedStream;
          return StreamBuilder<Address?>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppLoading(
                  alignment: AlignmentDirectional.centerStart,
                );
              } else {
                var address = snapshot.data;
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(MyAddressScreen.name);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YouText.labelLarge(
                          address != null ? address.title : 'Not selected'),
                      Row(
                        children: [
                          const YouText.labelMedium('Current location'),
                          Icon(
                            PIcons.outline_arrow___down_1,
                            size: 14.r,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
        child: const Text('Select Address'),
      ),
      leading: _leading(),
      actions: [
        const CartIcon(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            PIcons.outline_notification,
          ),
        ),
      ],
    );
  }

  Builder _leading() {
    return Builder(
      builder: (context) => IconButton(
        icon: const Icon(PIcons.outline_drawer),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => Size.fromHeight(45.h);
}
