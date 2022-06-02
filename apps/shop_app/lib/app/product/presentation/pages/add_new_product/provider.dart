import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p_core/p_core.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:shop_app/app/product/application/facade.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/domain/params/add_product.dart';
import 'package:shop_app/common/utils.dart';

import '../../../../category/domain/entities/tag.dart';

class AddProductProvider extends ChangeNotifier {
  AddProductProvider(this._productFacade, this._product)
      : _pageState = const PageState.init() {
    if (isEdit) {
      formGroup.value = _product!.toMap();
    }
  }

  final ProductFacade _productFacade;
  final Product? _product;
  PageState<void> _pageState;

  bool get isEdit => _product != null;

  PageState<void> get pageState => _pageState;

  set pageState(PageState<void> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  final controls = _Controls();

  late final FormGroup formGroup = FormGroup({
    'name': controls.name,
    'description': controls.description,
    'price': controls.price,
    'image': controls.image,
    'tag': controls.tags,
    'prepareTime': controls.duration,
  });

  Future<void> submitted(BuildContext context) async {
    if (controls.tags.value == null) {
      dismissAllAndShowError(context, 'Select tag!');
      return;
    }
    if (formGroup.valid) {
      pageState = const PageState.loading();

      final productParams = AddProductParams.fromMap(formGroup.value);

      late final ApiResult<void> result;
      if (isEdit) {
        result = await _productFacade.update(productParams.update(
          _product!.id,
        ));
      } else {
        result = await _productFacade.add(productParams);
      }

      result.when(
        success: (_) {
          pageState = const PageState.loaded(data: null);
          if (!isEdit) {
            EasyLoading.showSuccess('Product added');
            formGroup.reset();
          }
          EasyLoading.showSuccess('Product updated');
        },
        failure: (message, exception) {
          EasyLoading.showError(exception.message);
          pageState = PageState.error(exception: exception);
        },
      );
    } else {
      formGroup.markAllAsTouched();
    }
  }
}

class _Controls {
  final image = FormControl<ImageFile>(
    validators: [
      Validators.required,
    ],
  );
  final tags = FormControl<Tag>(
      // validators: [
      //   Validators.required,
      // ],
      );
  final name = FormControl(
    validators: [
      Validators.required,
      Validators.minLength(3),
    ],
  );
  final description = FormControl(
    validators: [
      Validators.required,
      Validators.minLength(10),
    ],
  );
  final price = FormControl<int>(
    validators: [
      Validators.required,
    ],
  );
  final duration = FormControl<Duration>(
    validators: [
      Validators.required,
    ],
  );
}
