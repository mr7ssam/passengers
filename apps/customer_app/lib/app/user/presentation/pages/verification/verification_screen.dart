import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';

import '../../../../../injection/service_locator.dart';
import 'bloc/verification_bloc.dart';

class VerificationScreen extends StatelessWidget {
  static const path = 'verification';
  static const name = 'verification';

  const VerificationScreen({Key? key}) : super(key: key);

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<VerificationBloc>(
        create: (context) => si(),
        child: const VerificationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final verificationBloc = context.read<VerificationBloc>();
    return BlocListener<VerificationBloc, VerificationState>(
      listener: _listener,
      child: Scaffold(
        appBar: PAppBar(),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            padding: PEdgeInsets.horizontal,
            child: Column(
              children: const [],
            ),
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, VerificationState state) {
    if (state is VerificationFailure) {
      EasyLoading.dismiss();
      final scaffoldMessengerState = ScaffoldMessenger.of(context);
      scaffoldMessengerState.removeCurrentSnackBar();
      scaffoldMessengerState
          .showSnackBar(SnackBar(content: Text(state.message)));
    } else if (state is VerificationLoading) {
      EasyLoading.show(
        status: 'In progress',
        maskType: EasyLoadingMaskType.black,
        indicator: const CircularProgressIndicator(),
      );
    } else if (state is VerificationSuccess) {
      EasyLoading.dismiss();
    }
  }
}
