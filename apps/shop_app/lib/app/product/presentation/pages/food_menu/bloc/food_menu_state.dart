part of 'food_menu_bloc.dart';

class FoodMenuState {
  FoodMenuState({required this.filter});

  factory FoodMenuState.init() => FoodMenuState(filter: const ProductsFilter());

  final ProductsFilter filter;

  FoodMenuState copyWith({
    ProductsFilter? filter,
  }) {
    return FoodMenuState(
      filter: filter ?? this.filter,
    );
  }
}
