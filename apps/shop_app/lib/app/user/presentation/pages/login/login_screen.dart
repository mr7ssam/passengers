import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/user/presentation/pages/sign_up/sign_up.dart';
import 'package:shop_app/common/utils.dart';
import 'package:shop_app/generated/locale_keys.g.dart';
import 'package:shop_app/injection/service_locator.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const path = 'login';
  static const name = 'login_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: const LoginScreen(),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => si(),
      child: Builder(
        builder: (context) {
          final loginBloc = context.read<LoginBloc>();
          return BlocListener<LoginBloc, LoginState>(
            listener: _listener,
            child: WillPopScope(
              onWillPop: () async => _onWillPop(loginBloc),
              child: Scaffold(
                appBar: PAppBar(),
                body: ReactiveForm(
                  formGroup: loginBloc.form,
                  child: SingleChildScrollView(
                    child: RPadding(
                      padding: PEdgeInsets.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Space.vL1,
                          YouText.headlineSmall(
                            LocaleKeys.user_login_headline.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Space.vS3,
                          Row(
                            children: [
                              YouText.labelLarge(
                                LocaleKeys.user_login_have_account.tr(),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                onPressed: () {
                                  context.goNamed(SignUpScreen.name);
                                },
                                child: Text(
                                  LocaleKeys.user_sign_up_title.tr(),
                                ),
                              ),
                            ],
                          ),
                          KeyboardVisibilityBuilder(
                            closed: () => Space.vL3,
                            open: () => Space.vM1,
                          ),
                          CustomReactiveTextField(
                            hintText: LocaleKeys.user_login_user_name.tr(),
                            prefix: PIcons.outline_profile,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  LocaleKeys.validations_user_name.tr(),
                            },
                            formControlName: LoginBloc.nameControllerName,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Space.vM2,
                          CustomReactiveTextField(
                            obscureText: true,
                            validationMessages: (control) => {
                              ValidationMessage.required:
                                  LocaleKeys.validations_password.tr(),
                            },
                            hintText: LocaleKeys.user_password.tr(),
                            prefix: PIcons.outline_lock,
                            formControlName: LoginBloc.passwordControllerName,
                          ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: TextButton(
                          //     child: Text(LocaleKeys.user_login_forget.tr()),
                          //     style: TextButton.styleFrom(
                          //         primary: Theme.of(context).disabledColor,
                          //         splashFactory: NoSplash.splashFactory,
                          //         padding: EdgeInsets.zero),
                          //     onPressed: () {},
                          //   ),
                          // ),
                          KeyboardVisibilityBuilder(
                            closed: () => Space.vL3,
                            open: () => Space.vM1,
                          ),
                          FilledButton(
                            onPressed: () {
                              context.setLocale(const Locale('en'));

                              _onLoginPressed(context);
                            },
                            child: Text(LocaleKeys.user_login_title.tr()),
                          ),
                          Space.vM2,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _onWillPop(LoginBloc loginBloc) {
    if (EasyLoading.isShow) {
      loginBloc.add(LoginCanceled());
      return false;
    }
    return true;
  }

  void _onLoginPressed(BuildContext context) {
    context.read<LoginBloc>().add(LoginSubmitted());
  }

  void _listener(BuildContext context, LoginState state) {
    if (state is LoginFailure) {
      final message = state.message;
      dismissAllAndShowError(context, message);
    } else if (state is LoginLoading) {
      showLoadingOverLay(message: LocaleKeys.user_login_logging.tr());
    } else if (state is LoginSuccess) {
      EasyLoading.dismiss();
    }
  }
}
