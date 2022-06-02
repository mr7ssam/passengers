import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/generated/locale_keys.g.dart';

import '../components/work_hours_bottom_sheet.dart';
import 'step_two_provider.dart';

class StepTow extends StatelessWidget {
  const StepTow({Key? key, required this.stepTwoProvider}) : super(key: key);
  final CompleteInfoStepTowProvider stepTwoProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: stepTwoProvider,
      builder: (context, _) {
        final listenableStepTowProvider =
            context.watch<CompleteInfoStepTowProvider>();
        return ReactiveForm(
          formGroup: stepTwoProvider.form,
          child: PageStateBuilder<void>(
            result: stepTwoProvider.pageState,
            success: (data) {
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Space.vM4,
                  CustomTitle(
                    icon: const Icon(PIcons.outline_categories),
                    label: Text(
                      LocaleKeys.user_complete_information_business_type_title
                          .tr(),
                    ),
                  ),
                  Space.vM2,
                  ReactiveDropdownSearch<Category, Category>(
                    validationMessages: (control) => {
                      ValidationMessage.required:
                          LocaleKeys.validations_required.tr(),
                    },
                    hint: LocaleKeys
                        .user_complete_information_business_type_title
                        .tr(),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(PIcons.outline_categories),
                        contentPadding: REdgeInsets.symmetric(
                          horizontal: 8,
                        )),
                    searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                      hintText: LocaleKeys.general_search.tr(),
                    )),
                    mode: Mode.BOTTOM_SHEET,
                    showSearchBox: true,
                    formControlName:
                        CompleteInfoStepTowProvider.categoriesControlName,
                    items: stepTwoProvider.categories,
                    itemAsString: (c) => c!.name,
                  ),
                  Space.vM4,
                  CustomTitle(
                    icon: const Icon(PIcons.outline_leg_chicken),
                    label: Text(
                      LocaleKeys.user_complete_information_sub_category_title
                          .tr(),
                    ),
                  ),
                  Space.vM2,
                  CustomChipSelect<Tag>.multi(
                    onChanged: (value) {
                      stepTwoProvider.tagControl.value = value;
                    },
                    itemAsString: (item) => item.name,
                    items: listenableStepTowProvider.tags,
                  ),
                  Space.vM2,
                  TextButton.icon(
                    label: const Text('Add another food list categories'),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _onAddCategory(context);
                    },
                  ),
                  Space.vL3,
                  FilledButton(
                      onPressed: () {
                        stepTwoProvider.onSubmitted(context);
                      },
                      child: Text(LocaleKeys.general_finish.tr())),
                ],
              ));
            },
            error: (message) {
              return IconButton(
                  onPressed: () {
                    stepTwoProvider.fetch();
                  },
                  icon: const Icon(Icons.refresh));
            },
          ),
        );
      },
    );
  }

  void _onAddCategory(BuildContext context) {
    final control = FormControl(validators: [Validators.required]);
    final formGroup = FormGroup({'tag': control});
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BottomSheetWrapperWidget(
          title: 'Add new category',
          children: [
            ReactiveForm(
              formGroup: formGroup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            if (formGroup.isValid()) {
                              Navigator.pop(context);
                              stepTwoProvider.addTag(control.value);
                            }
                          },
                          child: const Text('Add'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
