part of 'checkout_bloc.dart';

@immutable
class CheckoutState {
  const CheckoutState({
    required this.address,
    this.checkout = const PageState.init(),
    this.note,
  });

  final Address address;
  final PageState<Checkout> checkout;
  final String? note;

  CheckoutState copyWith({
    Address? address,
    PageState<Checkout>? checkout,
    String? note,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      checkout: checkout ?? this.checkout,
      note: note ?? this.note,
    );
  }
}
