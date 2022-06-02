import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';

import '../../../../../common/utils.dart';
import '../../../../../injection/service_locator.dart';
import '../../../domain/entities/user.dart';
import 'bloc/sign_up_bloc.dart';
import 'components/sign_up_header.dart';

class SignUpScreen extends StatelessWidget {
  static const path = 'sign_up';
  static const name = 'sign_up';

  const SignUpScreen({Key? key}) : super(key: key);

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(si()), child: const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignUpBloc>();
    return BlocListener<SignUpBloc, SignUpState>(
      listener: _listener,
      child: Scaffold(
        appBar: PAppBar(),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            padding: PEdgeInsets.listView,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SignUpHeader(),
                Space.vM3,
                CustomReactiveTextField<String>(
                  hintText: 'Full Name',
                  prefix: PIcons.outline_profile,
                  formControl: signUpBloc.controls.name,
                  keyboardType: TextInputType.emailAddress,
                ),
                Space.vM2,
                ReactiveDateTimePicker(
                  formControl: signUpBloc.controls.dob,
                  decoration: const InputDecoration(
                    labelText: 'yyyy/mm/dd',
                    prefixIcon: Icon(PIcons.outline_cake),
                  ),
                ),
                Space.vM2,
                ReactiveDropdownField(
                  items: Gender.values
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name),
                            value: e,
                          ))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'gender',
                    prefixIcon: Icon(PIcons.outline_gender),
                  ),
                  formControl: signUpBloc.controls.gender,
                ),
                Space.vM2,
                CustomReactiveTextField(
                  obscureText: true,
                  hintText: 'Password',
                  prefix: PIcons.outline_lock,
                  formControl: signUpBloc.controls.password,
                ),
                Space.vM2,
                CustomReactiveTextField(
                  hintText: 'Phone Number',
                  prefix: PIcons.outline_phone,
                  formControl: signUpBloc.controls.phone,
                ),
                Space.vM2,
                FilledButton(
                  onPressed: () {
                    signUpBloc.add(SignUpSubmitted());
                  },
                  child: const Text('Sign up'),
                ),
                Space.vM2,
              ],
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
      EasyLoading.show();
    } else if (state is SignUpSuccess) {
      EasyLoading.dismiss();
      context.pop();
    }
  }
}
