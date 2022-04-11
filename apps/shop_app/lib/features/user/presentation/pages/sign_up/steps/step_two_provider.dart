
import 'package:flutter/cupertino.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/user/presentation/pages/sign_up/bloc/sign_up_bloc.dart';
import '../../../../../../core/mixins/mixins.dart';

class StepTwoProvider with WizardStep, DisposableMixin {
  static const fullNameControllerName = 'fullName';
  static const businessNameControllerName = 'businessName';

  final form = fb.group(
    {
      fullNameControllerName: FormControl<String>(
        validators: [Validators.required],
      ),
      businessNameControllerName: FormControl<String>(
        validators: [Validators.required],
      ),
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
