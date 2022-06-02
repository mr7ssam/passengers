import 'dart:async';

import 'package:customer_app/app/products/presentation/pages/food_list_page/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'app/user/presentation/provider.dart';
import 'core/app_manger/bloc/app_manger_bloc.dart';
import 'injection/service_locator.dart';
import 'router/router.dart';

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
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(si()),
          ),
          ChangeNotifierProvider<FoodListPageProvider>(
            create: (context) => FoodListPageProvider(si())..fetch(),
          ),
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
