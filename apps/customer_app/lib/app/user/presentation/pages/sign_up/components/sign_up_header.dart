import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';

import '../../login/login_screen.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KeyboardVisibilityBuilder(
          closed: () => Space.vL1,
          open: () => const SizedBox.shrink(),
        ),
        const YouText.headlineSmall(
          'Hello!, Sign up'
          ' \nto get started',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Space.vS3,
        Row(
          children: [
            const YouText.labelLarge(
              'Are you have an account?',
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              onPressed: () {
                context.goNamed(LoginScreen.name);
              },
              child: const Text(
                'Login',
              ),
            ),
          ],
        ),
        KeyboardVisibilityBuilder(
          closed: () => Space.vM1,
          open: () => const SizedBox.shrink(),
        ),
      ],
    );
  }
}
