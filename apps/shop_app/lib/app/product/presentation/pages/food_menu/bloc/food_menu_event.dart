part of 'food_menu_bloc.dart';

@immutable
abstract class FoodMenuEvent {
  const FoodMenuEvent();
}

class FoodMenuFetched extends FoodMenuEvent {
  final int page;

  const FoodMenuFetched(this.page);
}

class FoodMenuProductDeleted extends FoodMenuEvent {
  final Product product;

  const FoodMenuProductDeleted(this.product);
}

class FoodMenuProductUpdated extends FoodMenuEvent {
  final Product product;

  const FoodMenuProductUpdated(this.product);
}

class FoodMenuTagsChanged extends FoodMenuEvent {
  final List<Tag> tags;

  const FoodMenuTagsChanged({
    required this.tags,
  });
}

class FoodMenuSearchChanged extends FoodMenuEvent {
  final String? text;

  const FoodMenuSearchChanged({
    required this.text,
  });
}
