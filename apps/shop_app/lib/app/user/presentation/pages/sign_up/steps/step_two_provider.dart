import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:p_core/p_core.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/app/user/presentation/pages/sign_up/bloc/sign_up_bloc.dart';

class StepTwoProvider with WizardStep, DisposableMixin {
  bool addressDirty = false;

  StepTwoProvider() {
    locationControl.valueChanges.listen((event) {
      if (!addressControl.valid || addressDirty) {
        addressDirty = true;
        addressControl.value = event!.address;
      }
    });
    addressControl.valueChanges.listen((event) {
      addressDirty = false;
    });
  }

  static const fullNameControllerName = 'ownerName';
  static const businessNameControllerName = 'name';
  static const businessLineAddressControllerName = 'address';
  static const locationControllerName = 'location';

  final addressControl = FormControl<String>(
    validators: [Validators.required],
  );
  final locationControl = FormControl<LocationResult>();

  late final form = fb.group(
    {
      fullNameControllerName: FormControl<String>(
        validators: [Validators.required],
      ),
      businessNameControllerName: FormControl<String>(
        validators: [Validators.required],
      ),
      businessLineAddressControllerName: addressControl,
      locationControllerName: locationControl
    },
  );

  void submitted(BuildContext context) {
    if (form.valid) {
      context.read<SignUpBloc>().add(SignUpSubmitted());
    } else {
      form.markAllAsTouched();
    }
  }
}
