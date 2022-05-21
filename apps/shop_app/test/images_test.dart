import 'dart:io';

import 'package:shop_app/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.deliveryCompany).existsSync(), true);
    expect(File(Images.manageShopApp).existsSync(), true);
    expect(File(Images.userFoodDeliveryApp).existsSync(), true);
    expect(File(Images.driver).existsSync(), true);
    expect(File(Images.complete).existsSync(), true);
    expect(File(Images.done).existsSync(), true);
    expect(File(Images.gift).existsSync(), true);
    expect(File(Images.info).existsSync(), true);
    expect(File(Images.lock1).existsSync(), true);
    expect(File(Images.lock2).existsSync(), true);
    expect(File(Images.manageOrder).existsSync(), true);
    expect(File(Images.orderBell).existsSync(), true);
    expect(File(Images.ordersSettings).existsSync(), true);
    expect(File(Images.phone).existsSync(), true);
    expect(File(Images.settings).existsSync(), true);
    expect(File(Images.appLogo).existsSync(), true);
    expect(File(Images.orderDone).existsSync(), true);
    expect(File(Images.orderInProgress).existsSync(), true);
    expect(File(Images.orderOnWay).existsSync(), true);
    expect(File(Images.orderPending).existsSync(), true);
    expect(File(Images.female).existsSync(), true);
    expect(File(Images.foods).existsSync(), true);
    expect(File(Images.male).existsSync(), true);
    expect(File(Images.shop).existsSync(), true);
  });
}
