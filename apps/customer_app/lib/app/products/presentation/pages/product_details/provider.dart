import 'package:flutter/cupertino.dart';
import 'package:p_core/p_core.dart';

import '../../../application/facade.dart';
import '../../../domain/entities/product_details.dart';

class ProductDetailsProvider extends ChangeNotifier {
  ProductDetailsProvider(this._productFacade, this.productId)
      : _pageState = const PageState.loading();

  final ProductFacade _productFacade;
  final String productId;
  PageState<ProductDetails> _pageState;

  PageState<ProductDetails> get pageState => _pageState;

  set pageState(PageState<ProductDetails> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  Future<void> loadProduct() async {
    pageState = const PageState.loading();
    final result = await _productFacade.getProductDetails(
      ParamsWrapper({
        'productId': productId,
      }),
    );
    result.when(success: (data) {
      pageState = PageState.loaded(data: data);
    }, failure: (message, e) {
      pageState = PageState.error(exception: e);
    });
  }
}
