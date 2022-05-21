import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/user/presentation/pages/login/login_screen.dart';

import '../../../../../../generated/locale_keys.g.dart';

class SignUpHeader extends StatelessWidget {

  const SignUpHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Space.vL1,
        YouText.headlineSmall(
          LocaleKeys.user_sign_up_headline.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Space.vS3,
        Row(
          children: [
            YouText.labelLarge(
              LocaleKeys.user_sign_up_have_account.tr(),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              onPressed: () {
                context.goNamed(LoginScreen.name);
              },
              child: Text(
                LocaleKeys.user_login_title.tr(),
              ),
            ),
          ],
        ),
        KeyboardVisibilityBuilder(
          closed: () => Space.vL3,
          open: () => Space.vM1,
        ),
      ],
    );
  }
}
