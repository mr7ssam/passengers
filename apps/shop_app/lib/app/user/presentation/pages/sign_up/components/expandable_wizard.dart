import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

/// A widget to create a multi-step wizard with separated state files.
class ExpandableWizard extends StatelessWidget {
  /// Creates a [Wizard] to create a multi-step wizard with separated state
  /// files.
  ///
  /// stepBuilder: The builder method to build the steps corresponding widget. The builder
  /// method provides the [BuildContext] and [WizardStepState]. The state can
  /// then be used to determine how to build the view.
  ///
  /// Example:
  /// ```dart
  /// stepBuilder: (context, state) {
  ///   if (state is StepOneProvider) {
  ///     return StepOne(
  ///       provider: state,
  ///     );
  ///   }
  ///   if (state is StepTwoProvider) {
  ///     return StepTwo(
  ///       provider: state,
  ///     );
  ///   }
  ///   return Container();
  /// },
  /// ```
  const ExpandableWizard({
    required this.stepBuilder,
    Key? key,
    this.padding,
  }) : super(key: key);

  /// The builder method to build the steps corresponding widget. The builder
  /// method provides the [BuildContext] and [WizardStepState]. The state can
  /// then be used to determine how to build the view.
  ///
  /// Example:
  /// ```dart
  /// stepBuilder: (context, state) {
  ///   if (state is StepOneProvider) {
  ///     return StepOne(
  ///       provider: state,
  ///     );
  ///   }
  ///   if (state is StepTwoProvider) {
  ///     return StepTwo(
  ///       provider: state,
  ///     );
  ///   }
  ///   return Container();
  /// },
  /// ```
  final WizardStepBuilder stepBuilder;

  final EdgeInsets? padding;

  @protected
  @override
  Widget build(
    BuildContext context,
  ) {
    return ExpandablePageView.builder(
      animationDuration: const Duration(milliseconds: 200),
      controller: context.wizardController.pageController,
      itemCount: context.wizardController.stepControllers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: stepBuilder(
            context,
            context.wizardController.stepControllers[index].step,
          ),
        );
      },
      // TODO: Improve
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
