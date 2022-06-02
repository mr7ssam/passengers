import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/app/root/presentation/pages/drawer/settings/pages/food_list_and_categories/provider.dart';
import 'package:shop_app/app/root/presentation/pages/home/home.dart';
import 'package:shop_app/app/user/presentation/pages/complete_info/components/work_hours_bottom_sheet.dart';
import 'package:shop_app/injection/service_locator.dart';

class FoodListCategoriesSettings extends StatelessWidget {
  const FoodListCategoriesSettings({Key? key}) : super(key: key);

  static const path = 'food-list-settings';
  static const name = 'food_list_settings_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
          create: (context) =>
              FoodListCategoriesSettingsProvider(si())..fetch(),
          child: const FoodListCategoriesSettings()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: const Icon(PIcons.outline_plus),
            onPressed: () {
              _onAddCategory(context);
            },
          ),
        ),
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.vL1,
            Padding(
              padding: PEdgeInsets.horizontal,
              child: const YouText.titleLarge('Food list categories'),
            ),
            Expanded(
              child: Consumer<FoodListCategoriesSettingsProvider>(
                  builder: (context, provider, child) {
                return RefreshIndicator(
                  onRefresh: () async {
                    provider.fetch();
                  },
                  child: PageStateBuilder<List<Tag>>(
                    result: provider.pageState,
                    success: (state) {
                      if (state.isEmpty) {
                        return const EmptyWidget(
                          path: EmptyState.noCategories,
                          title: 'No tags yet!',
                        );
                      }
                      return ListView.separated(
                        padding: PEdgeInsets.listView +
                            PEdgeInsets.bottomFloatBuffer,
                        itemBuilder: (context, index) {
                          final tag = state[index];
                          return CustomListTile(
                            trilling: PopupMenuButton(
                              icon: const Icon(PIcons.outline_kabab),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () async {
                                    await _onDeletePressed(
                                      context,
                                      themeData,
                                      provider,
                                      tag,
                                    );
                                  },
                                  child: const ListTile(
                                    title: Text('Delete'),
                                    leading: Icon(PIcons.outline_delete),
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    final formControl = FormControl(
                                      value: tag.name,
                                      validators: [
                                        Validators.required,
                                      ],
                                    );

                                    Future.delayed(
                                      Duration.zero,
                                      () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return BottomSheetWrapperWidget(
                                              title: 'Edit Tag Name',
                                              children: [
                                                Space.vM1,
                                                CustomReactiveTextField(
                                                  formControl: formControl,
                                                ),
                                                Space.vM1,
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                    ),
                                                    Space.hS2,
                                                    Expanded(
                                                      child: FilledButton(
                                                        child:
                                                            const Text('Save'),
                                                        onPressed: () {
                                                          if (formControl
                                                              .valid) {
                                                            provider.updateTag(
                                                                tag.copyWith(
                                                                    name: formControl
                                                                        .value),
                                                                index,
                                                                context);
                                                          } else {
                                                            formControl
                                                                .markAllAsTouched();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Space.vM1,
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: const ListTile(
                                    title: Text('Edit Name'),
                                    leading: Icon(PIcons.outline_edit),
                                  ),
                                ),
                              ],
                            ),
                            text: tag.name,
                          );
                        },
                        separatorBuilder: (_, __) => Space.vM1,
                        itemCount: state.length,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddCategory(BuildContext context) {
    final control = FormControl(validators: [Validators.required]);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return BottomSheetWrapperWidget(
          title: 'Add new category',
          children: [
            Space.vL1,
            CustomReactiveTextField(
              labelText: 'Category name',
              hintText: 'Enter the new category name',
              formControl: control,
            ),
            Space.vM2,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (control.isValid()) {
                        context
                            .read<FoodListCategoriesSettingsProvider>()
                            .addTag(control.value, context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _onDeletePressed(BuildContext context, ThemeData themeData,
      FoodListCategoriesSettingsProvider provider, Tag tag) async {
    Future.delayed(Duration.zero, () async {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        title: 'Delete Tag',
        desc: 'Are you sure you want to delete this tag?',
        btnCancelColor: themeData.primaryColor,
        btnOk: OutlinedButton(
          child: const Text('Delete'),
          onPressed: () {
            provider.deleteTag(tag, context);
          },
        ),
        btnCancel: FilledButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ).show();
    });
  }
}
