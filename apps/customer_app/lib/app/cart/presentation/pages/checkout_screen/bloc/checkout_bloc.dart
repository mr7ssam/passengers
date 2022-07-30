import 'dart:async';

import 'package:customer_app/app/cart/application/facade.dart';
import 'package:customer_app/app/cart/domain/entities/checkout.dart';
import 'package:customer_app/app/cart/domain/repositories/checkout_params.dart';
import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';

import '../../../../domain/entities/cart.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(CheckoutState initState, this.cartFacade)
      : addressControl = FormControl(value: initState.address),
        super(initState) {
    on<CheckoutEvent>(_handler);
    addressControl.valueChanges.listen(
      (event) {
        add(CheckoutAddressChanged(event!));
      },
    );
  }

  final CartFacade cartFacade;
  late final Cart _cart;
  final FormControl<Address> addressControl;

  void setCart(Cart cart) => _cart = cart;

  FutureOr<void> _handler(
      CheckoutEvent event, Emitter<CheckoutState> emit) async {
    if (event is CheckoutStarted) {
      _cart = event.cart;
    } else if (event is CheckedOut) {
      await _checkedOut(emit);
    } else if (event is CheckoutAddressChanged) {
      emit(state.copyWith(address: event.address));
      add(CheckedOut());
    }
  }

  Future<void> _checkedOut(Emitter<CheckoutState> emit) async {
    emit(state.copyWith(checkout: const PageState.loading()));
    final result = await cartFacade.checkout(
      CheckoutParams(cart: _cart, address: state.address),
    );
    result.when(
      success: (data) {
        emit(state.copyWith(checkout: PageState.loaded(data: data)));
      },
      failure: (message, exception) {
        emit(state.copyWith(checkout: PageState.error(exception: exception)));
      },
    );
  }
}
