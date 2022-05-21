import 'package:easy_localization/easy_localization.dart' as sign_up_screen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/user/presentation/pages/sign_up/components/expandable_wizard.dart';
import 'package:shop_app/app/user/presentation/pages/sign_up/components/sign_up_header.dart';
import 'package:shop_app/app/user/presentation/pages/sign_up/components/steps_progress.dart';
import 'package:shop_app/common/utils.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../../../../generated/locale_keys.g.dart';
import 'bloc/sign_up_bloc.dart';
import 'components/steps_controll_buttons.dart';
import 'steps/steps.dart';

class SignUpScreen extends StatelessWidget {
  static const path = 'sign_up';
  static const name = 'sign_up';

  const SignUpScreen({Key? key}) : super(key: key);

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<SignUpBloc>(
          create: (context) => si(), child: const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignUpBloc>();
    return DefaultWizardController(
      stepControllers: [
        WizardStepController(
          step: signUpBloc.stepOneProvider,
        ),
        WizardStepController(
          step: signUpBloc.stepTowProvider,
        ),
      ],
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: _listener,
        child: Scaffold(
          floatingActionButton: StepOneFloatingActionButton(
            stepIndex: 0,
            onPressed: (step) {
              (step as StepOneProvider).goNext();
            },
          ),
          appBar: PAppBar(),
          body: Builder(
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: PEdgeInsets.horizontal,
                      child: const SignUpHeader()),
                  ExpandableWizard(
                    padding: PEdgeInsets.horizontal,
                    stepBuilder: (BuildContext context, WizardStep step) {
                      if (step is StepOneProvider) {
                        return StepOne(
                          step: step,
                        );
                      }
                      if (step is StepTwoProvider) {
                        return StepTwo(
                          step: step,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Space.vL1,
                  const Center(child: StepsProgress()),
                  Space.vXL1,
                  Padding(
                      padding: PEdgeInsets.horizontal,
                      child: const StepTwoButtons()),
                  Space.vM3,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, SignUpState state) {
    if (state is SignUpFailure) {
      final message = state.message;
      dismissAllAndShowError(context, message);
    } else if (state is SignUpLoading) {
      showLoadingOverLay(message: LocaleKeys.user_login_logging.tr());
    } else if (state is SignUpSuccess) {
      EasyLoading.dismiss();
      context.pop();
    }
  }
}
