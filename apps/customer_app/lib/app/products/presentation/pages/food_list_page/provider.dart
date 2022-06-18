import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:p_core/p_core.dart';

import '../../../application/facade.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/shop.dart';
import '../../../domain/entities/tag.dart';

class FoodListPageProvider extends ChangeNotifier {
  FoodListPageProvider(this._productFacade)
      : _shops = [],
        _pageState = const PageState.loading() {
    pagingController.addPageRequestListener((pageKey) {
      fetchProducts(pageKey);
    });
  }

  final ProductFacade _productFacade;

  final PagingController<int, Product> pagingController =
      PagingController<int, Product>(firstPageKey: 1);

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

  fetchProducts(int pageKey) async {
    final result = await _productFacade.getProducts(FetchProductParams(
      tag: selectedTag,
      shop: selectedShop,
      page: pageKey,
    ));

    result.when(
      success: (pagingData) {
        if (pagingData.isLastPage()) {
          pagingController.appendLastPage(pagingData.data);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(pagingData.data, nextPageKey);
        }
      },
      failure: (message, e) {
        pagingController.error = result.failure;
      },
    );
  }

  void selectShop(Shop shop) async {
    if (shop == selectedShop) {
      return;
    }
    final _selectedShop = selectedShop;
    final _tags = tags;
    final _tag = selectedTag;
    selectedShop = shop;
    tags = null;
    final result = await _productFacade.getTags(
      ParamsWrapper({'shopId': selectedShop!.id}),
    );
    result.when(
      success: (tags) {
        this.tags = tags;
        selectedTag = null;
        pagingController.refresh();
      },
      failure: (_, __) {
        tags = _tags;
        selectedShop = _selectedShop;
        selectedTag = _tag;
      },
    );
  }

  void selectTag(Tag? tag) {
    selectedTag = tag;
    pagingController.refresh();
  }
}

class FetchProductParams extends PagingParams {
  final Tag? tag;
  final Shop? shop;

  FetchProductParams({super.page, required this.tag, required this.shop});

  @override
  Map<String, dynamic> toMap() => {
        if (tag != null) 'tagId': tag!.id,
        if (shop != null) 'shopId': shop!.id,
      }..addAll(super.toMap());
}
