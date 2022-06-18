import 'dart:async';

import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p_core/p_core.dart';

import '../../../application/facade.dart';

class MyAddressProvider extends ChangeNotifier {
  MyAddressProvider(this._userFacade);

  init() {
    stream = _userFacade.addressStream;
  }

  final UserFacade _userFacade;

  late Stream<List<Address>?> _stream;

  Stream<List<Address>?> get stream => _stream;

  set stream(Stream<List<Address>?> stream) {
    _stream = stream;
    notifyListeners();
  }

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

  Future<void> addTag(String tagName, BuildContext context) async {
    // EasyLoading.show(status: 'Adding tag...');
    // final result = await _categoryFacade
    //     .addTag(ParamsWrapper(Address.insert(tag: tagName).toMap()));
    // result.when(success: (tag) {
    //   EasyLoading.dismiss();
    //   pageState = pageState.loaded.copyWith(
    //     data: List.from(pageState.data..insert(0, tag)),
    //   );
    //   Navigator.pop(context);
    // }, failure: (message, e) {
    //   EasyLoading.showError(message);
    // });
  }

  updateTag(
    Address address,
    int index,
    BuildContext context,
  ) async {
    EasyLoading.show(status: 'Updating...');
    final result = await _userFacade.updateAddress(
      ParamsWrapper(address.toMap()),
    );
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
}
