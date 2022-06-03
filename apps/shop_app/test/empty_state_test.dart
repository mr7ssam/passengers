import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/resources/resources.dart';

void main() {
  test('empty_state assets test', () {
    expect(File(EmptyState.comingSoon).existsSync(), true);
    expect(File(EmptyState.moon).existsSync(), true);
    expect(File(EmptyState.noAddress).existsSync(), true);
    expect(File(EmptyState.noBodyThere).existsSync(), true);
    expect(File(EmptyState.noCategories).existsSync(), true);
    expect(File(EmptyState.noInternetConnection).existsSync(), true);
    expect(File(EmptyState.noItemInCart).existsSync(), true);
    expect(File(EmptyState.noItemInFavorite).existsSync(), true);
    expect(File(EmptyState.noMeal).existsSync(), true);
    expect(File(EmptyState.noNotifications).existsSync(), true);
    expect(File(EmptyState.noOffers).existsSync(), true);
    expect(File(EmptyState.noOrders).existsSync(), true);
    expect(File(EmptyState.noReviews).existsSync(), true);
    expect(File(EmptyState.noShop).existsSync(), true);
    expect(File(EmptyState.noStatistic).existsSync(), true);
    expect(File(EmptyState.offline).existsSync(), true);
    expect(File(EmptyState.somethingWentWrong).existsSync(), true);
  });
}
