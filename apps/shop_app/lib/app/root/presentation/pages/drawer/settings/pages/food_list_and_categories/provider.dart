import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p_core/p_core.dart';
import 'package:shop_app/app/category/application/facade.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';

class FoodListCategoriesSettingsProvider extends ChangeNotifier {
  FoodListCategoriesSettingsProvider(this._categoryFacade)
      : _pageState = const PageState.loading();
  final CategoryFacade _categoryFacade;

  PageState<List<Tag>> _pageState;

  PageState<List<Tag>> get pageState => _pageState;

  set pageState(PageState<List<Tag>> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  fetch() async {
    pageState = const PageState.loading();
    final result = await _categoryFacade.getShopTags();
    result.when(
      success: (data) {
        pageState = PageState.loaded(data: data);
      },
      failure: (message, e) {
        pageState = PageState.error(exception: e);
      },
    );
  }

  deleteTag(
    Tag tag,
    BuildContext context,
  ) async {
    EasyLoading.show(status: 'Deleting...');
    final result = await _categoryFacade.deleteTag(
      ParamsWrapper({'id': tag.id}),
    );
    EasyLoading.dismiss();
    result.when(
      success: (data) {
        EasyLoading.showSuccess('Deleted');
        Navigator.pop(context);
        pageState = pageState.loaded.copyWith(
          data: List.from(pageState.data)..remove(tag),
        );
      },
      failure: (message, e) {
        EasyLoading.showError('Failed: $message');
      },
    );
  }

  Future<void> addTag(String tagName, BuildContext context) async {
    EasyLoading.show(status: 'Adding tag...');
    final result = await _categoryFacade
        .addTag(ParamsWrapper(Tag.insert(tag: tagName).toMap()));
    result.when(success: (tag) {
      EasyLoading.dismiss();
      pageState = pageState.loaded.copyWith(
        data: List.from(pageState.data..insert(0, tag)),
      );
      Navigator.pop(context);
    }, failure: (message, e) {
      EasyLoading.showError(message);
    });
  }

  updateTag(
    Tag tag,
    int index,
    BuildContext context,
  ) async {
    EasyLoading.show(status: 'Updating...');
    final result = await _categoryFacade.updateTag(
      ParamsWrapper(tag.toMap()),
    );
    EasyLoading.dismiss();
    result.when(
      success: (data) {
        EasyLoading.showSuccess('Updated');
        Navigator.pop(context);
        pageState.data[index] = tag;
        pageState = pageState.loaded.copyWith(
          data: List.from(pageState.data),
        );
      },
      failure: (message, e) {
        EasyLoading.showError('Failed: $message');
      },
    );
  }
}
