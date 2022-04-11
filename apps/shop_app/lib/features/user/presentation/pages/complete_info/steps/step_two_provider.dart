import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/core/page_state/page_state.dart';
import 'package:shop_app/features/category/application/api.dart';
import 'package:shop_app/features/category/domain/entities/category.dart';
import 'package:shop_app/features/category/domain/entities/tag.dart';

import '../bloc/complete_information_bloc.dart';

class CompleteInfoStepTowProvider with WizardStep, ChangeNotifier {
  CompleteInfoStepTowProvider(this._categoryApi)
      : _pageState = const PageState.init();

  final CategoryApi _categoryApi;

  PageState<Tuple2<List<Category>, List<Tag>>> _pageState;

  static const categoriesControlName = 'mainCategory';
  static const subCategoriesControlName = 'tags';

  final tagControl = FormControl<List<Tag>>();
  final categoriesControl = FormControl<Category>();

  late final form = fb.group({
    categoriesControlName: categoriesControl,
    subCategoriesControlName: tagControl,
  });

  PageState<Tuple2<List<Category>, List<Tag>>> get pageState => _pageState;

  set pageState(PageState<Tuple2<List<Category>, List<Tag>>> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  Future<void> fetch() async {
    pageState = const PageState.loading();

    final result = await _categoryApi.getAllTagsAndCategories();
    result.when(success: (data) {
      pageState = PageState.loaded(data: data);
    }, failure: (error) {
      pageState = PageState.error(error: error);
    });
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
