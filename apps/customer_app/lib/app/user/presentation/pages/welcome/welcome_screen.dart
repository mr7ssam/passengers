import 'package:customer_app/app/user/application/facade.dart';
import 'package:customer_app/injection/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  si<UserFacade>().skip();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Skip'),
                    Space.hS3,
                    Icon(PIcons.outline_arrow___right_4),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  Images.userFoodDeliveryApp,
                  package: kDesignPackageName,
                ),
              ),
            ),
            Space.vL1,
            Column(
              children: [
                const YouText.headlineSmall(
                  'Your order knowsyou well',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Space.vM2,
                const FractionallySizedBox(
                  widthFactor: 0.7,
                  child: FittedBox(
                    child: YouText.labelLarge(
                      'If you need to order delivery, no need for \n'
                      'much noise, order and put your phone\n'
                      ' aside, your order knows you well.',
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
                    child: const Text('Sign up'),
                  ),
                ),
                Space.vS3,
                FractionallySizedBox(
                  widthFactor: buttonWidthFactor,
                  child: OutlinedButton(
                    onPressed: () => _onLoginPressed(context),
                    child: const Text('Login'),
                  ),
                ),
                Space.vXL1,
              ],
            ),
          ],
        ),
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
