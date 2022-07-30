part of '../const.dart';

const kBaseAPIUrl = '$kBaseUrl/api';
// const kBaseUrl = 'https://nawat-solutions.com';
const kBaseUrl = 'http://passengers-001-site1.gtempurl.com';

abstract class APIRoutes {
  APIRoutes._();

  static const shop = _Shop();

  static const order = _Order();

  static const category = _Category();

  static const tag = _Tag();

  static const product = _Product();
}

class _Shop {
  const _Shop();

  final login = '/Shop/Login';
  final signUp = '/Shop/SignUp';
  final completeInformation = '/Shop/CompleteInfo';
  final getProfile = '/Shop/GetProfile';
  final getInfo = '/Shop/Details';
  final updateInfo = '/Shop/update';
  final updateWorkDays = '/Shop/UpdateWorkingDays';
  final updateWorkHours = '/Shop/UpdateWorkingTimes';
  final updateImage = '/Shop/UpdateImage';
  final getWorkingDays = '/Shop/GetWorkingDays';
  final refreshToken = '/Account/RefreshToken';
}

class _Category {
  const _Category();

  final getAllCategories = '/Category/Get';
}

class _Tag {
  const _Tag();

  final getAllTags = '/Tag/Get';
  final getShopTags = '/Tag/GetTags';
  final getPublic = '/Tag/GetPublicTag';
  final addTag = '/Tag/add';
  final update = '/Tag/update';
  final delete = '/Tag/delete';
}

class _Product {
  const _Product();

  final getAllProducts = '/Product/Get';
  final addProduct = '/Product/add';
  final updateProduct = '/Product/update';
  final updateProductPrice = '/Product/ChangePrice';
  final updateAvailability = '/Product/ChangeAvilable';
  final getProductDetails = '/Product/GetById';
  final delete = '/Product/delete';
  final home = '/Shop/home';
}

class _Order {
  const _Order();

  final getAll = '/Order/GetShopOrders';
  final markAsReady = '/Order/Ready';
}
