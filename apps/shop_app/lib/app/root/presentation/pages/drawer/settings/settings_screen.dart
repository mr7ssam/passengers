import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:shop_app/app/root/presentation/pages/drawer/settings/pages/working_days/working_days_settings.dart';
import 'package:shop_app/app/user/domain/entities/user_profile.dart';
import 'package:shop_app/app/user/presentation/pages/user_info/user_info_screen.dart';
import 'package:shop_app/app/user/presentation/provider.dart';
import 'package:shop_app/common/utils.dart';
import 'package:shop_app/app_manger/bloc/app_manger_bloc.dart';
import 'package:shop_app/injection/service_locator.dart';

import 'bloc/settings_bloc.dart';
import 'pages/food_list_and_categories/page.dart';

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
            itemBuilder: (context) => <PopupMenuEntry>[
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
                  await _onEditImagePressed(context);
                },
                child: const ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: Icon(PIcons.outline_add_picture),
                  title: Text('Add new photo'),
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  context.read<AppMangerBloc>().add(AppMangerLoggedOut());
                },
                child: const ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: Icon(PIcons.outline_logout),
                  title: Text('Logout'),
                ),
              ),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SettingsBloc>().retry();
        },
        child: SingleChildScrollView(
          padding: PEdgeInsets.listView,
          child: Column(
            children: [
              Space.vM3,
              Consumer<UserProvider>(
                builder: (context, value, child) {
                  final user = value.user!;
                  return Column(
                    children: [
                      Hero(
                          tag: 'avatar',
                          child: ImageAvatar(
                              imagePath: buildDocUrl(user.imagePath))),
                      Space.vM2,
                      YouText.headlineSmall(user.name ?? ''),
                    ],
                  );
                },
              ),
              Space.vM1,
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return PageStateBuilder<UserProfile>(
                    result: state.profileState,
                    error: (e) => Text(e.message),
                    success: (data) {
                      var icon = PIcons.outline_star;
                      var rate = data.rate.toStringAsFixed(1);
                      return Column(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                        onTap: () {
                          context.pushNamed(FoodListCategoriesSettings.name);
                        },
                      ),
                      CustomListTile(
                        icon: const Icon(PIcons.outline_calendar___time),
                        text: 'Manage schedule work',
                        onTap: () {
                          context.pushNamed(WorkingDaysSettings.name);
                        },
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
      ),
    );
  }

  Future<void> _onEditImagePressed(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Edit your image profile',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
      );
      if (croppedFile != null) {
        context.read<SettingsBloc>().add(SettingsUserImageEdited(croppedFile));
      }
    }
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
      body: ExtendedImage.file(
        image,
      ),
    );
  }
}
