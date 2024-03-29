import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import '../../../../application/facade.dart';
import '../../../../domain/entities/address.dart';

class AddAddressProvider extends ChangeNotifier {
  final UserFacade _userFacade;

  final Controls controls = Controls();

  late final FormGroup formGroup = FormGroup(controls.controls);

  AddAddressProvider(this._userFacade) : _pageState = const PageState.init();

  init(Address? address) {
    formGroup.value = address?.toMap() ?? {};
  }

  PageState<void> _pageState;

  PageState<void> get pageState => _pageState;

  set pageState(PageState<void> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  bool get isEdit => controls.id.value != null;

  Future<void> submitted(BuildContext context) async {
    if (formGroup.isValid()) {
      pageState = const PageState.loading();

      final address = Address.fromMap(formGroup.value);

      late final ApiResult<void> result;
      if (isEdit) {
        result = await _userFacade.updateAddress(address);
      } else {
        result = await _userFacade.addAddress(address);
      }

      result.when(
        success: (_) {
          pageState = const PageState.loaded(data: null);
          if (!isEdit) {
            EasyLoading.showSuccess('Address added');
            formGroup.reset();
          } else {
            EasyLoading.showSuccess('Address updated');
          }
        },
        failure: (message, exception) {
          EasyLoading.showError(exception.message);
          pageState = PageState.error(exception: exception);
        },
      );
    }
  }
}

class Controls {
  final id = FormControl<String>();

  final title = FormControl<String>(
    validators: [
      Validators.required,
      Validators.minLength(3),
    ],
  );

  final building = FormControl<String>(
    validators: [
      Validators.required,
      Validators.minLength(7),
    ],
  );

  final text = FormControl<String>(
    validators: [
      Validators.required,
    ],
  );

  final phoneNumber = FormControl<String>();

  final note = FormControl<String>();

  final location = FormControl<LatLng>(
      // validators: [Validators.required],
      );

  late Map<String, FormControl> controls = {
    'id': id,
    'title': title,
    'building': building,
    'text': text,
    'phoneNumber': phoneNumber,
    'note': note,
    'location': location,
  };
}
