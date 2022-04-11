part of '../const.dart';

const kBaseUrl = 'https://nawat-solutions.com/api';

abstract class APIRoutes {
  APIRoutes._();

  static const _Account account = _Account();

  static const _Category category = _Category();

  static const _Tag tag = _Tag();
}

class _Account {
  const _Account();

  final login = '/Shop/Login';
  final signUp = '/Shop/SignUp';
  final completeInformation = '/Shop/CompleteInfo';
  final getProfile = '/Shop/GetProfile';
  final getInfo = '/Shop/Details';
  final updateInfo = '/Shop/update';
  final refreshToken = '/Account/RefreshToken';
}

class _Category {
  const _Category();

  final getAllCategories = '/Category/Get';
}

class _Tag {
  const _Tag();

  final getAllTags = '/Tag/Get';
  final addTag = '/Tag/add';
}
