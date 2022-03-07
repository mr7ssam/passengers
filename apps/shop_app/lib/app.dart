import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp.router(
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        routeInformationParser:
            AppRouter(context: context).routeInformationParser,
        routerDelegate: AppRouter(context: context).routerDelegate,
        title: 'Passengers Shop',
        useInheritedMediaQuery: true,
        theme: lightTheme,
      ),
    );
  }
}
