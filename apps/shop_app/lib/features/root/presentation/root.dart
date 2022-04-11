import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/app_manger/bloc/app_manger_bloc.dart';
import 'package:shop_app/features/root/presentation/manager/root_manger.dart';
import 'package:shop_app/features/root/presentation/pages/settings/settings_screen.dart';

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
    return Scaffold(
      bottomNavigationBar: Builder(
        builder: (context) {
          final rootManger = context.watch<RootManger>();
          final selectedIndex = rootManger.pageIndex;
          print(selectedIndex);
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: NavigationBar(
                key: ValueKey(selectedIndex),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                backgroundColor: Theme.of(context).cardColor,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  rootManger.jump(index);
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
                    selectedIcon: Icon(PIcons.fill_fire),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(PIcons.outline_bell_ring),
                    selectedIcon: Icon(PIcons.fill_bell_ring),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(PIcons.outline_graph),
                    selectedIcon: Icon(PIcons.fill_graph),
                    label: '',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Icon(Icons.supervised_user_circle),
            ),
            ListTile(
              leading: const Icon(PIcons.outline_settings),
              title: const Text('Settings'),
              style: ListTileStyle.drawer,
              horizontalTitleGap: 0,
              onTap: () {
                context.goNamed(SettingsScreen.name);
              },
            ),
            ListTile(
              leading: const Icon(PIcons.outline_info_circle),
              title: const Text('About us'),
              horizontalTitleGap: 0,
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(PIcons.outline_headphones),
              title: const Text('Contact services'),
              horizontalTitleGap: 0,
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(PIcons.outline_feedback),
              title: const Text('Feed Back'),
              horizontalTitleGap: 0,
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(PIcons.outline_logout),
              title: const Text('Logout'),
              horizontalTitleGap: 0,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content:
                            const Text('Are you sure to logout from this app?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AppMangerBloc>()
                                  .add(AppMangerLoggedOut());
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
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
        children: const [
          Text('home'),
          Text('food'),
          Text('fire'),
          Text('food2'),
          Text('stat'),
        ],
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
