import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../products/presentation/pages/food_list_page/food_list_screen.dart';
import 'manager/root_manger.dart';
import 'pages/home/home.dart';
import 'widgets/drawer.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);
  static const path = '/root';
  static const name = 'root_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
          create: (context) => RootManger(), child: const RootScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coming = Center(
      child: SvgPicture.asset(
        EmptyState.comingSoon,
        package: kDesignPackageName,
      ),
    );
    return Scaffold(
      bottomNavigationBar: Builder(
        builder: (context) {
          final rootManger = context.watch<RootManger>();
          final selectedIndex = rootManger.pageIndex;
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                backgroundColor: Theme.of(context).cardColor,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  rootManger.jump(index);
                },
                destinations: [
                  const NavigationDestination(
                    icon: Icon(PIcons.outline_home),
                    selectedIcon: Icon(PIcons.fill_home),
                    label: '',
                  ),
                  const NavigationDestination(
                    icon: Icon(PIcons.outline_leg_chicken),
                    selectedIcon: Icon(PIcons.fill_leg_chicken),
                    label: '',
                  ),
                  const NavigationDestination(
                    icon: Icon(PIcons.outline_fire),
                    selectedIcon: Icon(PIcons.fill_offer),
                    label: '',
                  ),
                  const NavigationDestination(
                    icon: Icon(PIcons.outline_shop),
                    selectedIcon: Icon(PIcons.fill_shop),
                    label: '',
                  ),
                  const NavigationDestination(
                    icon: Icon(PIcons.outline_bell_ring),
                    selectedIcon: Icon(PIcons.fill_bell_ring),
                    label: '',
                  ),
                ]
                    .mapIndexed((index, element) => NavigationPlayAnimation(
                          index: index,
                          child: element,
                          selectedIndex: selectedIndex,
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: _leading(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              PIcons.outline_notification,
            ),
          )
        ],
      ),
      body: PageView(
        controller: context.read<RootManger>().pageController,
        children: [
          const HomePage(),
          const FoodListPage(),
          coming,
          coming,
          coming,
        ].map((e) => KeepAliveWidget(child: e)).toList(),
      ),
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
      curve: Curves.elasticInOut,
      builder: (context, child, value) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
    );
  }
}
