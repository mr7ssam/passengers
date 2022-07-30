import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';

import '../../../../../injection/service_locator.dart';
import '../../../domain/entities/user.dart';
import 'bloc/user_info_bloc.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  static const path = 'user-info';
  static const name = 'user_info_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<UserInfoBloc>(
        create: (context) => UserInfoBloc(si())..add(UseInfoStarted()),
        child: const UserInfoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfoBloc = context.read<UserInfoBloc>();
    return Scaffold(
      appBar: PAppBar(
        title: 'Personal Info',
        actions: [
          TextButton.icon(
            icon: const Icon(PIcons.outline_check),
            onPressed: () {
              context.read<UserInfoBloc>().add(UseInfoSubmitted());
            },
            label: const Text('Save'),
          ),
        ],
      ),
      body: ReactiveForm(
        formGroup: userInfoBloc.form,
        child: Builder(
          builder: (context) => BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoLoading) {
                return const AppLoading();
              } else if (state is UserInfoFailure) {
                return APIErrorWidget(exception: state.exception);
              }
              return SingleChildScrollView(
                padding: PEdgeInsets.horizontal,
                child: Column(
                  children: [
                    CustomReactiveTextField<String>(
                      hintText: 'Full Name',
                      prefix: PIcons.outline_profile,
                      formControl: userInfoBloc.controls.name,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Space.vM2,
                    ReactiveDateTimePicker(
                      formControl: userInfoBloc.controls.dob,
                      decoration: const InputDecoration(
                        labelText: 'yyyy/mm/dd',
                        prefixIcon: Icon(PIcons.outline_cake),
                      ),
                    ),
                    Space.vM2,
                    ReactiveDropdownField(
                      items: Gender.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'gender',
                        prefixIcon: Icon(PIcons.outline_gender),
                      ),
                      formControl: userInfoBloc.controls.gender,
                    ),
                    Space.vM2,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
