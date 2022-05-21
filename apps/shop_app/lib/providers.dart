import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/product/presentation/pages/food_menu/bloc/food_menu_bloc.dart';
import 'package:shop_app/app/user/presentation/provider.dart';
import 'package:shop_app/router/router.dart';

import 'core/app_manger/bloc/app_manger_bloc.dart';
import 'injection/service_locator.dart';

class Providers extends StatelessWidget {
  final WidgetBuilder builder;

  const Providers({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppMangerBloc(
            doBeforeOpen: _doBeforeOpen,
          )..add(AppMangerStarted()),
        ),
        BlocProvider(
          create: (_) => FoodMenuBloc(si()),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(si()),
          )
        ],
        builder: (context, _) => Provider<AppRouter>(
          create: (context) => AppRouter(context: context),
          builder: (context, _) => builder(context),
        ),
      ),
    );
  }

  FutureOr<void> _doBeforeOpen() async {
    WidgetsFlutterBinding.ensureInitialized();
    await inject();
  }
}
