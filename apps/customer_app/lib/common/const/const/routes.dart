part of '../const.dart';

const kBaseAPIUrl = '$kBaseUrl/api';
const kBaseUrl = 'https://nawat-solutions.com';

abstract class APIRoutes {
  APIRoutes._();

  static const _User user = _User();

  static const _Shop shop = _Shop();

  static const _Category category = _Category();

  static const _Product product = _Product();
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
