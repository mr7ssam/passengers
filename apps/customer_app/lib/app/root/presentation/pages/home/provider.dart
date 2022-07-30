import 'package:flutter/material.dart';
import 'package:p_core/p_core.dart';

import '../../../../products/application/facade.dart';
import '../../../../products/domain/entities/home_data.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(this._productFacade) : _state = const PageState.loading();

  final ProductFacade _productFacade;

  PageState<HomeData> _state;

  PageState<HomeData> get state => _state;

  set state(PageState<HomeData> state) {
    _state = state;
    notifyListeners();
  }

  void fetch() async {
    state = const PageState.loading();
    final result = await _productFacade.homeData();
    result.when(
      success: (data) {
        state = PageState.loaded(data: data);
      },
      failure: (message, e) {
        state = PageState.error(exception: e);
      },
    );
  }
}
