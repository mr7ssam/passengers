import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/app/product/application/facade.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/domain/params/params.dart';

part 'food_menu_event.dart';
part 'food_menu_state.dart';

class FoodMenuBloc extends Bloc<FoodMenuEvent, FoodMenuState>
    with RetryBlocMixin {
  FoodMenuBloc(this._facade) : super(FoodMenuState.init()) {
    pagingController.addPageRequestListener(_pageRequestListener);
    on<FoodMenuEvent>(
      _handler,
    );
    formControl.valueChanges
        .debounce((_) => TimerStream(true, const Duration(milliseconds: 400)))
        .listen((event) {
      add(FoodMenuSearchChanged(text: event));
    });
  }

  final formControl = FormControl<String>();
  final ProductFacade _facade;
  final PagingController<int, Product> pagingController =
      PagingController<int, Product>(firstPageKey: 1);

  void _pageRequestListener(int pageKey) {
    add(FoodMenuFetched(pageKey));
  }

  FutureOr<void> _handler(
    FoodMenuEvent event,
    Emitter<FoodMenuState> emit,
  ) async {
    if (event is FoodMenuFetched) {
      await _fetch(event.page);
    } else if (event is FoodMenuProductDeleted) {
      final itemList = pagingController.itemList;
      pagingController.itemList =
          List.from(itemList!..removeAt(event.product.index!));
    } else if (event is FoodMenuProductUpdated) {
      if (pagingController.itemList == null) return;
      final itemList = pagingController.itemList;
      final index = itemList!.indexWhere(
        (element) => element.id == event.product.id,
      );
      itemList[index] = event.product;
      pagingController.itemList = List.from(itemList);
    } else if (event is FoodMenuTagsChanged) {
      emit(state.copyWith(filter: state.filter.copyWith(tags: event.tags)));
      pagingController.refresh();
    } else if (event is FoodMenuSearchChanged) {
      emit(state.copyWith(filter: state.filter.copyWith(search: event.text)));
      pagingController.refresh();
    }
  }

  Future<void> _fetch(int page) async {
    final result = await _facade.getAll(
      GetProductParams(
        filter: state.filter,
        page: page,
      ),
    );

    result.when(
      success: (pagingData) {
        if (pagingData.isLastPage()) {
          pagingController.appendLastPage(pagingData.data);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(pagingData.data, nextPageKey);
        }
      },
      failure: (message, e) {
        pagingController.error = result.failure;
      },
    );
  }
}
