import 'package:flutter/material.dart';
import 'package:shop_app/app/product/application/facade.dart';
import 'package:shop_app/app/product/domain/entities/home_data.dart';
import 'package:shop_app/core/page_state/page_state.dart';

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
    final result = await _productFacade.getHomeData();
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
