import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/features/user/application/facade.dart';

import '../domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(this._facade) {
    _user = _facade.user;
    _subscribeToUser();
  }

  void _subscribeToUser() {
    _subscription = _facade.userStream.listen((user) {
      this.user = user;
    });
  }

  final UserFacade _facade;
  late final StreamSubscription _subscription;
  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
