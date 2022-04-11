import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/features/user/presentation/pages/sign_up/steps/step_one_provider.dart';

import '../../../../../../generated/locale_keys.g.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    Key? key,
    required this.step,
  }) : super(key: key);
  final StepOneProvider step;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: step.form,
      child: Column(
        children: [
          ReactiveIntlPhoneFormField(
            formControlName: StepOneProvider.phoneNumberControllerName,
            validationMessages: (control) => {
              ValidationMessage.required:
              LocaleKeys.validations_phone_number.tr(),
            },
          ),
          Space.vM2,
          CustomReactiveTextField(
            obscureText: true,
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_password.tr(),
            },
            hintText: LocaleKeys.user_password.tr(),
            prefix: PIcons.outline_lock,
            formControlName: StepOneProvider.passwordControllerName,
          ),
        ],
      ),
    );
  }
}
