import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';

import '../../../../../common/utils.dart';
import '../../../../../injection/service_locator.dart';
import '../../../../../router/routes.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const path = 'login';
  static const name = 'login_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(si()), child: const LoginScreen()),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
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
                        const YouText.headlineSmall(
                          'Hello again!\n'
                          'We missed you!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Space.vS3,
                        Row(
                          children: [
                            const YouText.labelLarge(
                              'Not have an account?',
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              onPressed: () {
                                context.goNamed(SignUpScreen.name);
                              },
                              child: const Text(
                                'Sign up',
                              ),
                            ),
                          ],
                        ),
                        KeyboardVisibilityBuilder(
                          closed: () => Space.vL3,
                          open: () => Space.vM1,
                        ),
                        const CustomReactiveTextField(
                          hintText: 'Phone Number',
                          prefix: PIcons.outline_profile,
                          formControlName: LoginBloc.phoneNumberControllerName,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Space.vM2,
                        const CustomReactiveTextField(
                          obscureText: true,
                          hintText: 'Password',
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
                            _onLoginPressed(context);
                          },
                          child: const Text('Login'),
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
      EasyLoading.show();
    } else if (state is LoginSuccess) {
      EasyLoading.dismiss();
    }
  }
}
