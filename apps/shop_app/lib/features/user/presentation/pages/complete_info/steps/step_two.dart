import 'package:darq/darq.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/core/page_state/page_state.dart';
import 'package:shop_app/features/category/domain/entities/category.dart';
import 'package:shop_app/features/category/domain/entities/tag.dart';
import 'package:shop_app/generated/locale_keys.g.dart';
import 'step_two_provider.dart';

class StepTow extends StatelessWidget {
  const StepTow({Key? key, required this.stepTwoProvider}) : super(key: key);
  final CompleteInfoStepTowProvider stepTwoProvider;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: stepTwoProvider.form,
      child: PageStateBuilder<Tuple2<List<Category>, List<Tag>>>(
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
                  LocaleKeys.user_complete_information_main_category_title.tr(),
                ),
              ),
              Space.vM2,
              ReactiveDropdownSearch<Category, Category>(
                validationMessages: (control) => {
                  ValidationMessage.required:
                      LocaleKeys.validations_password.tr(),
                },
                hint: LocaleKeys.user_complete_information_main_category_title
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
                items: data.item0,
                itemAsString: (c) => c!.name,
              ),
              Space.vM4,
              CustomTitle(
                icon: const Icon(PIcons.outline_leg_chicken),
                label: Text(
                  LocaleKeys.user_complete_information_sub_category_title.tr(),
                ),
              ),
              Space.vM2,
              CustomChipSelect<Tag>(
                onChanged: (value) {
                  stepTwoProvider.tagControl.value = value;
                },
                itemAsString: (item) => item.name,
                items: data.item1,
              ),
              Space.vL3,
              ElevatedButton(
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
  }
}

enum CustomChipSelectType {
  list,
  wrap,
}

class CustomChipSelect<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) itemAsString;
  final List<T> selectedItems;
  final ValueChanged<List<T>>? onChanged;
  final CustomChipSelectType type;

  const CustomChipSelect({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedItems = const [],
    required this.itemAsString,
    this.type = CustomChipSelectType.wrap,
  }) : super(key: key);

  @override
  State<CustomChipSelect> createState() => _CustomChipSelectState<T>();
}

class _CustomChipSelectState<T> extends State<CustomChipSelect<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    _selectedItems = List.from(widget.selectedItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == CustomChipSelectType.list) {
      return RSizedBox(
        height: 50,
        child: ListView.separated(
          itemCount: widget.items.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const RSizedBox.horizontal(8),
          itemBuilder: (context, index) {
            return _buildFilterChips(index);
          },
        ),
      );
    }
    return Wrap(
      spacing: 8.r,
      runSpacing: 8.r,
      children: List.generate(
          widget.items.length, (index) => _buildFilterChips(index)),
    );
  }

  FilterChip _buildFilterChips(int index) {
    final items = widget.items;
    final item = items[index];
    final selected = _selectedItems.contains(item);
    return FilterChip(
      selected: selected,
      onSelected: (value) {
        if (value) {
          _selectedItems.add(item);
        } else {
          _selectedItems.remove(item);
        }
        widget.onChanged?.call(items);
        setState(() {});
      },
      side: selected ? BorderSide.none : null,
      label: Text(
        widget.itemAsString(
          item,
        ),
      ),
    );
  }
}
