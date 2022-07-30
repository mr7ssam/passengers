import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../login/login_screen.dart';
import '../sign_up/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  static const path = '/welcome';
  static const name = 'welcome';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: const WelcomeScreen(),
    );
  }

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonWidthFactor = 0.55;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                Images.manageShopApp,
              ),
            ),
          ),
          Space.vL1,
          Column(
            children: [
              YouText.headlineSmall(
                LocaleKeys.user_welcome_headline.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Space.vM2,
              FractionallySizedBox(
                widthFactor: 0.7,
                child: FittedBox(
                  child: YouText.labelLarge(
                    LocaleKeys.user_welcome_sub_title.tr(),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
              ),
              Space.vL1,
              FractionallySizedBox(
                widthFactor: buttonWidthFactor,
                child: TonalButton(
                  onPressed: () => _onSignUpPressed(context),
                  child: Text(LocaleKeys.user_sign_up_title.tr()),
                ),
              ),
              Space.vS3,
              FractionallySizedBox(
                widthFactor: buttonWidthFactor,
                child: OutlinedButton(
                  onPressed: () => _onLoginPressed(context),
                  child: Text(LocaleKeys.user_login_title.tr()),
                ),
              ),
              Space.vXL1,
            ],
          ),
        ],
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    context.goNamed(LoginScreen.name, extra: {});
  }

  void _onSignUpPressed(BuildContext context) {
    context.goNamed(SignUpScreen.path);
  }
}
