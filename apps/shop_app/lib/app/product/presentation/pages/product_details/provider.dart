import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/app/product/application/facade.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/domain/entities/product_details.dart';
import 'package:shop_app/app/product/presentation/pages/food_menu/bloc/food_menu_bloc.dart';
import 'package:shop_app/core/page_state/page_state.dart';
import 'package:shop_app/core/remote/params.dart';

class ProductDetailsProvider extends ChangeNotifier {
  ProductDetailsProvider(this._productFacade, this.product)
      : _pageState = const PageState.loading();

  final ProductFacade _productFacade;
  final Product product;
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
        'id': product.id,
      }),
    );
    result.when(success: (data) {
      pageState = PageState.loaded(data: data);
    }, failure: (message, e) {
      pageState = PageState.error(exception: e);
    });
  }

  deleteProduct(BuildContext context) async {
    EasyLoading.show(status: 'Deleting...');
    final result = await _productFacade.delete(ParamsWrapper(
      {'id': product.id},
    ));
    EasyLoading.dismiss();
    result.when(success: (data) {
      context.pop();
      context.read<FoodMenuBloc>().add(FoodMenuProductDeleted(product));
    }, failure: (message, e) {
      EasyLoading.showError(message);
    });
  }

  updatePrice(String price, BuildContext context) async {
    EasyLoading.show(status: 'Updating price...');
    final newPrice = double.parse(price);
    final result = await _productFacade.updatePrice(ParamsWrapper(
      {'id': product.id, 'newPrice': newPrice},
    ));
    EasyLoading.dismiss();
    result.when(success: (data) {
      Navigator.pop(context);
      pageState = pageState.loaded.copyWith(
        data: pageState.data.copyWith(price: newPrice),
      );
      context.read<FoodMenuBloc>().add(FoodMenuProductUpdated(product));
    }, failure: (message, e) {
      EasyLoading.showError(message);
    });
  }

  updateAvailability(BuildContext context) async {
    EasyLoading.show(status: 'Updating availability...');
    final result = await _productFacade.updateAvailability(ParamsWrapper(
      {'id': product.id},
    ));
    EasyLoading.dismiss();
    result.when(success: (data) {
      final data = pageState.data;
      pageState = pageState.loaded.copyWith(
        data: data.copyWith(available: !data.available),
      );
      context.read<FoodMenuBloc>().add(
          FoodMenuProductUpdated(product.copyWith(avilable: !data.available)));
    }, failure: (message, e) {
      EasyLoading.showError(message);
    });
  }
}
