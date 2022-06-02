import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:p_core/p_core.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StepOneProvider with WizardStep, DisposableMixin {
  static const phoneNumberControllerName = 'phoneNumber';
  static const passwordControllerName = 'password';

  final phoneNumberController = FormControl<PhoneNumber>(
    value: PhoneNumber(countryISOCode: 'SY', countryCode: '+963', number: ''),
    validators: [Validators.required],
  );

  final passwordController = FormControl<String>(
    validators: [Validators.required],
  );

  late final form = fb.group(
    {
      phoneNumberControllerName: phoneNumberController,
      passwordControllerName: passwordController,
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
