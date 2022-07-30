part of '../const.dart';

const kBaseAPIUrl = '$kBaseUrl/api';
const kBaseUrl = 'http://passengers-001-site1.gtempurl.com';
// const kBaseUrl = 'https://nawat-solutions.com';

abstract class APIRoutes {
  APIRoutes._();

  static const ordersHub = '$kBaseUrl/orderHub';

  static const user = _User();

  static const address = _Address();

  static const shop = _Shop();

  static const category = _Category();

  static const product = _Product();

  static const order = _Order();
}

class _User {
  const _User();

  final login = '/Customer/Login';
  final signUp = '/Customer/SignUp';
  final getProfile = '/Customer/GetProfile';
  final getInfo = '/Customer/Details';
  final updateInfo = '/Customer/UpdateInformation';
  final updateImage = '/Customer/UploadImage';
  final refreshToken = '/Account/RefreshToken';
}

class _Address {
  const _Address();

  final getAll = '/Address/GetCustomerAddresses';
  final add = '/Address/AddCustomerAddress';
  final update = '/Address/UpdateCustomerAddress';
  final setCurrent = '/Address/SetCurrentAddress';
  final delete = '/Address/Delete';
}

class _Category {
  const _Category();

  final getShopTags = '/Tag/GetByShopId';
  final getAllCategories = '/Category/Get';
  final getAllTags = '/Tag/Get';
}

class _Shop {
  const _Shop();

  final getAllShops = '/Customer/GetShops';
  final getShopDetails = '/Customer/ShopDetails';
}

class _Product {
  const _Product();

  final getProducts = '/Customer/GetProducts';
  final getProductDetails = '/Customer/ProductDetails';
  final home = '/Customer/home';
}

class _Order {
  const _Order();

  final expectedCost = '/Order/GetExpectedCost';
  final myCart = '/Order/GetMyCart';
  final addOrder = '/Order/AddOrder';
  final orders = '/Order/GetCustomerOrders';
  final orderDetails = '/Order/GetOrderDetails';
  final orderById = '/Order/GetCustomerOrderById';
}
