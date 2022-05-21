part of '../const.dart';

const kBaseAPIUrl = '$kBaseUrl/api';
const kBaseUrl = 'https://nawat-solutions.com';

abstract class APIRoutes {
  APIRoutes._();

  static const _Shop shop = _Shop();

  static const _Category category = _Category();

  static const _Tag tag = _Tag();

  static const _Product product = _Product();
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
