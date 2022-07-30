part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class CheckoutStarted extends CheckoutEvent {
  final Cart cart;

  CheckoutStarted(this.cart);
}

class CheckedOut extends CheckoutEvent {}

class CheckoutAddressChanged extends CheckoutEvent {
  final Address address;

  CheckoutAddressChanged(this.address);
}
