import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/common/utils.dart';
import 'package:shop_app/core/app_manger/bloc/app_manger_bloc.dart';
import 'package:shop_app/core/extension.dart';
import 'package:shop_app/features/root/presentation/root.dart';
import 'package:shop_app/features/user/presentation/pages/complete_info/steps/step_two.dart';
import 'package:shop_app/features/user/presentation/pages/sign_up/components/expandable_wizard.dart';
import 'package:shop_app/generated/locale_keys.g.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../sign_up/components/steps_controll_buttons.dart';
import '../sign_up/components/steps_progress.dart';
import 'bloc/complete_information_bloc.dart';
import 'steps/steps.dart';

class CompleteInfoScreen extends StatelessWidget {
  static const path = '/complete-info';
  static const name = 'complete-info';

  const CompleteInfoScreen({Key? key}) : super(key: key);

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<CompleteInformationBloc>(
          create: (context) => si<CompleteInformationBloc>(),
          child: const CompleteInfoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CompleteInformationBloc>();
    return BlocListener<CompleteInformationBloc, CompleteInformationState>(
      listener: _listener,
      child: DefaultWizardController(
        stepControllers: [
          WizardStepController(
            step: bloc.stepOneProvider,
          ),
          WizardStepController(
            step: bloc.stepTowProvider,
          ),
        ],
        child: Scaffold(
          floatingActionButton: StepOneFloatingActionButton(
            stepIndex: 0,
            onPressed: (step) {
              (step as CompleteInfoStepOneProvider).goNext();
            },
          ),
          appBar: PAppBar(
            title: LocaleKeys.user_complete_information_title.tr(),
            actions: [
              IconButton(
                onPressed: () => _onLogoutPressed(context),
                icon: const Icon(PIcons.outline_logout),
              )
            ],
          ),
          body: Builder(
            builder: (context) => SafeArea(
              child: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    padding: PEdgeInsets.listView,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Space.vM3,
                        Builder(builder: (context) {
                          final wizardController = context.wizardController;
                          return RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: [
                                TextSpan(text: LocaleKeys.general_step.tr()),
                                TextSpan(
                                    text: (wizardController.index + 1)
                                        .toString()),
                                TextSpan(text: LocaleKeys.general_of.tr()),
                                TextSpan(
                                    text: (wizardController.stepCount)
                                        .toString()),
                              ].superJoin(const TextSpan(text: ' ')).toList(),
                            ),
                          );
                        }),
                        Space.vM3,
                        const StepsProgress(),
                        Space.vM3,
                        ExpandableWizard(
                          stepBuilder: (context, step) {
                            if (step is CompleteInfoStepOneProvider) {
                              return StepOne(
                                stepOneProvider: step,
                              );
                            }
                            if (step is CompleteInfoStepTowProvider) {
                              return StepTow(
                                stepTwoProvider: step,
                              );
                            }
                            return const SizedBox();
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, CompleteInformationState state) {
    if (state is CompleteInformationFailure) {
      final message = state.message;
      dismissAllAndShowError(context, message);
    } else if (state is CompleteInformationLoading) {
      showLoadingOverLay();
    } else if (state is CompleteInformationSuccess) {
      EasyLoading.dismiss();
      context.goNamed(RootScreen.name);
    }
  }

  void _onLogoutPressed(BuildContext context) {
    context.read<AppMangerBloc>().add(AppMangerLoggedOut());
  }
}
