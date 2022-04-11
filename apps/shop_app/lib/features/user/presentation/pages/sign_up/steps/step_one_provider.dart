import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../core/mixins/mixins.dart';

class StepOneProvider with WizardStep, DisposableMixin {
  static const phoneNumberControllerName = 'phoneNumber';
  static const passwordControllerName = 'password';

  final form = fb.group(
    {
      phoneNumberControllerName: FormControl<PhoneNumber>(
        value:
            PhoneNumber(countryISOCode: 'SY', countryCode: '+963', number: ''),
        validators: [Validators.required],
      ),
      passwordControllerName: FormControl<String>(
        validators: [Validators.required],
      ),
    },
  );

  void goNext() {
    if (form.valid) {
      wizardController.goNext();
    } else {
      form.markAllAsTouched();
    }
  }
}
