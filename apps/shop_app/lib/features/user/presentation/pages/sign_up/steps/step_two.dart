import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/features/user/presentation/pages/sign_up/steps/step_two_provider.dart';
import '../../../../../../generated/locale_keys.g.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({
    Key? key,
    required this.step,
  }) : super(key: key);

  final StepTwoProvider step;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: step.form,
      child: Column(
        children: [
          CustomReactiveTextField(
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_full_name.tr(),
            },
            hintText: LocaleKeys.user_sign_up_full_name.tr(),
            prefix: PIcons.outline_profile,
            formControlName: StepTwoProvider.fullNameControllerName,
          ),
          Space.vM2,
          CustomReactiveTextField(
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_business_name.tr(),
            },
            hintText: LocaleKeys.user_sign_up_business_name.tr(),
            prefix: PIcons.outline_shop,
            formControlName: StepTwoProvider.businessNameControllerName,
          ),
        ],
      ),
    );
  }
}
