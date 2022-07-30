import 'dart:async';

import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p_core/p_core.dart';
import 'package:rxdart/rxdart.dart';

import '../../../application/facade.dart';
import 'package:collection/collection.dart';

class MyAddressProvider extends ChangeNotifier {
  MyAddressProvider(this._userFacade)
      : addressesSubject = BehaviorSubject<List<Address>?>();

  void start() {
    _userFacade.addressStream.listen((event) {
      addressesSubject.add(event);
    });
    notifyListeners();
  }

  late BehaviorSubject<List<Address>?> addressesSubject;

  final UserFacade _userFacade;

  Stream<Address?> get selectedStream =>
      stream.map((event) => event?.firstOrNull);

  Stream<List<Address>?> get stream => addressesSubject.stream;

  deleteAddress(
    Address address,
    BuildContext context,
  ) async {
    EasyLoading.show(status: 'Deleting...');
    final result = await _userFacade.deleteAddress(
      address,
    );
    EasyLoading.dismiss();
    result.when(
      success: (data) {
        EasyLoading.showSuccess('Deleted');
        Navigator.pop(context);
      },
      failure: (message, e) {
        EasyLoading.showError('Failed: $message');
      },
    );
  }

  updateAddress(
    Address address,
    int index,
    BuildContext context,
  ) async {
    EasyLoading.show(status: 'Updating...');
    final result = await _userFacade.updateAddress(address);
    EasyLoading.dismiss();
    result.when(
      success: (newAddress) {
        EasyLoading.showSuccess('Updated');
        Navigator.pop(context);
      },
      failure: (message, e) {
        EasyLoading.showError('Failed: $message');
      },
    );
  }

  setCurrentAddress(
    Address address,
    int index,
    BuildContext context,
  ) async {
    EasyLoading.show(status: 'Updating...');
    final result = await _userFacade.setCurrent(address);
    EasyLoading.dismiss();
    result.when(
      success: (newAddress) {
        EasyLoading.showSuccess('Updated');
      },
      failure: (message, e) {
        EasyLoading.showError('Failed: $message');
      },
    );
  }

  @override
  dispose() {
    super.dispose();
    addressesSubject.close();
  }
}
