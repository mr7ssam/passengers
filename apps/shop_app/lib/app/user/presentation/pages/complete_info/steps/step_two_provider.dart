import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/app/category/application/api.dart';
import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/core/page_state/page_state.dart';

import '../bloc/complete_information_bloc.dart';

class CompleteInfoStepTowProvider with WizardStep, ChangeNotifier {
  CompleteInfoStepTowProvider(this._categoryApi)
      : _pageState = const PageState.init();

  List<Tag> _tags = [];

  List<Tag> get tags => _tags;

  List<Category> _categories = [];

  List<Category> get categories => _categories;

  final CategoryApi _categoryApi;

  PageState<void> _pageState;

  static const categoriesControlName = 'mainCategory';
  static const subCategoriesControlName = 'tags';

  final tagControl = FormControl<List<Tag>>();
  final mainCategoryControl = FormControl<Category>(validators: [
    Validators.required,
  ]);
  late final form = fb.group({
    categoriesControlName: mainCategoryControl,
    subCategoriesControlName: tagControl,
  });

  PageState<void> get pageState => _pageState;

  set pageState(PageState<void> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  set categories(List<Category> categories) {
    _categories = categories;
    notifyListeners();
  }

  set tags(List<Tag> tags) {
    _tags = tags;
    notifyListeners();
  }

  Future<void> fetch() async {
    pageState = const PageState.loading();

    final result = await _categoryApi.getAllTagsAndCategories();
    result.when(success: (data) {
      pageState = const PageState.loaded(data: null);
      tags = data.item1;
      categories = data.item0;
    }, failure: (message, e) {
      pageState = PageState.error(exception: e);
    });
  }

  Future<void> addTag(String tagName) async {
    final tag = Tag.insert(tag: tagName);
    tags = [...tags, tag];
  }

  onSubmitted(BuildContext context) {
    if (form.valid) {
      context
          .read<CompleteInformationBloc>()
          .add(CompleteInformationSubmitted());
    } else {
      form.markAllAsTouched();
    }
  }
}
