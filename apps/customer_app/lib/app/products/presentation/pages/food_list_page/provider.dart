import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:p_core/p_core.dart';

import '../../../application/facade.dart';
import '../../../domain/entities/shop.dart';
import '../../../domain/entities/tag.dart';

class FoodListPageProvider extends ChangeNotifier {
  FoodListPageProvider(this._productFacade)
      : _shops = [],
        _pageState = const PageState.loading();

  final ProductFacade _productFacade;

  PageState<Tuple2<List<Shop>, List<Tag>>> _pageState;

  List<Shop> _shops;
  Shop? _selectedShop;

  Tag? _selectedTag;

  List<Tag>? _tags;

  List<Tag>? get tags => _tags;

  PageState<Tuple2<List<Shop>, List<Tag>>> get pageState => _pageState;

  List<Shop> get shops => _shops;

  Shop? get selectedShop => _selectedShop;

  Tag? get selectedTag => _selectedTag;

  set pageState(PageState<Tuple2<List<Shop>, List<Tag>>> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  set shops(List<Shop> shops) {
    _shops = shops;
    notifyListeners();
  }

  set tags(List<Tag>? tags) {
    _tags = tags;
    notifyListeners();
  }

  set selectedTag(Tag? tag) {
    _selectedTag = tag;
    notifyListeners();
  }

  set selectedShop(Shop? selectedShop) {
    _selectedShop = selectedShop;
    notifyListeners();
  }

  fetch() async {
    pageState = const PageState.loading();
    final data = await _productFacade.getFoodListData();
    data.when(
      success: (data) {
        if (data.item0.isEmpty) {
          pageState = const PageState.empty();
        } else {
          shops = data.item0;
          tags = data.item1;
          selectedShop = shops.first;
          pageState = PageState.loaded(data: data);
        }
      },
      failure: (message, exception) {
        pageState = PageState.error(exception: exception);
      },
    );
  }

  void selectShop(Shop shop) async {
    if(shop == selectedShop) {
      return;
    }
    final _selectedShop = selectedShop;
    final _tags = tags;
    selectedShop = shop;
    tags = null;
    final result = await _productFacade.getTags(
      ParamsWrapper({'shopId': selectedShop!.id}),
    );
    result.when(success: (tags) {
      this.tags = tags;
    }, failure: (_, __) {
      tags = _tags;
      selectedShop = _selectedShop;
    });
  }

  void selectTag(Tag tag) {
    selectedTag = tag;
  }
}
