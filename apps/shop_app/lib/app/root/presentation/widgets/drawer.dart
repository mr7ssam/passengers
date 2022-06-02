import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/user/presentation/provider.dart';
import 'package:shop_app/common/utils.dart';
import 'package:shop_app/core/app_manger/bloc/app_manger_bloc.dart';

import '../pages/drawer/settings/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            final user = value.user;
            if (user == null) {
              return const SizedBox();
            }
            return ListView(
              children: [
                RPadding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'avatar',
                        child: ImageAvatar(
                          imagePath: buildDocUrl(
                            user.imagePath,
                          ),
                        ),
                      ),
                      const RSizedBox.vertical(16),
                      YouText.headlineSmall(user.name ?? ''),
                      YouText.labelMedium(user.categoryName ?? ''),
                    ],
                  ),
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
                    _onLogoutPressed(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onLogoutPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: REdgeInsets.all(24),
          actionsPadding: REdgeInsets.all(24),
          title: const Text('Logout'),
          content: const Text('Are you sure to logout from this app?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            OutlinedButton(
              onPressed: () {
                context.read<AppMangerBloc>().add(AppMangerLoggedOut());
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
