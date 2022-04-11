import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:shop_app/core/page_state/page_state.dart';
import 'package:shop_app/features/user/domain/entities/user_profile.dart';
import 'package:shop_app/features/user/presentation/pages/user_info/user_info_screen.dart';

import '../../../../../injection/service_locator.dart';
import 'bloc/settings_bloc.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const path = 'settings';
  static const name = 'settings_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider(
          create: (context) => SettingsBloc(si())..add(SettingsStarted()),
          child: const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PAppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(PIcons.outline_kabab),
            itemBuilder: (context) => <PopupMenuEntry<WhyFarther>>[
              PopupMenuItem(
                onTap: () {
                  context.pushNamed(UserInfoScreen.name);
                },
                child: const ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: Icon(PIcons.outline_edit),
                  title: Text('Edit Information'),
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  final image = await ImagePicker.platform
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImageSelectionConfirm(image: File(image.path)),
                        ));
                  }
                },
                child: ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: Icon(PIcons.outline_add_picture),
                  title: Text('Add new photo'),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: PEdgeInsets.listView,
        child: Column(
          children: [
            Space.vM3,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return PageStateBuilder<UserProfile>(
                  result: state.profileState,
                  success: (data) {
                    var icon = PIcons.outline_star;
                    var rate = data.rate.toStringAsFixed(1);
                    return Column(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              UserImageAvatar(imagePath: data.imagePath),
                              Space.vM2,
                              YouText.headlineSmall(data.name),
                              if (data.categoryName != null) ...[
                                Space.vS2,
                                YouText.titleMedium(data.categoryName!),
                              ]
                            ],
                          ),
                        ),
                        Space.vM3,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TitledIcon(icon: icon, text: rate),
                            TitledIcon(
                                icon: PIcons.outline_profile,
                                text: data.followerCount.toString()),
                            TitledIcon(
                                icon: PIcons.outline_leg_chicken,
                                text: data.productCount.toString()),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Space.vL1,
            Column(
              children: [
                CustomListTile(
                  icon: const Icon(PIcons.outline_profile),
                  text: 'Personal info',
                  borderRadius: PRadius.button,
                  onTap: () {
                    context.pushNamed(UserInfoScreen.name);
                  },
                ),
                Space.vM3,
                TitledContainer(
                  title: 'Settings',
                  children: [
                    CustomListTile(
                      icon: const Icon(PIcons.outline_leg_chicken),
                      text: 'Food list and categories',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_date___time),
                      text: 'Working days and hours',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_bell_ring),
                      text: 'Order settings',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_notification),
                      text: 'Sound and notifications',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_lock),
                      text: 'Privacy and security',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_website),
                      text: 'Languages',
                      onTap: () {},
                    ),
                  ],
                ),
                Space.vM3,
                TitledContainer(
                  title: 'Help',
                  children: [
                    CustomListTile(
                      icon: const Icon(PIcons.outline_headphones),
                      text: 'Customer services',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_q_mark_circle),
                      text: 'Platform FAQ',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_info_2),
                      text: 'Terms and Conditions',
                      onTap: () {},
                    ),
                    CustomListTile(
                      icon: const Icon(PIcons.outline_privacy),
                      text: 'Privacy and policy',
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
            Space.vL1,
          ],
        ),
      ),
    );
  }
}

class ImageSelectionConfirm extends StatelessWidget {
  final File image;
  final void Function(File image)? onConfirm;

  const ImageSelectionConfirm({Key? key, required this.image, this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(PIcons.outline_check),
        onPressed: () {
          Navigator.pop(context);
          onConfirm?.call(image);
        },
      ),
      body: ExtendedImage.file(image,),
    );
  }
}
