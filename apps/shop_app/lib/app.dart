import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/providers.dart';
import 'package:shop_app/router/router.dart';

final _easyLoadingInit = EasyLoading.init();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Providers(
      builder: (context) {
        return ScreenUtilInit(
          builder: () {
            final appRouter = AppRouter.of(context);
            return MaterialApp.router(
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              routeInformationParser: appRouter.goRouter.routeInformationParser,
              routerDelegate: appRouter.goRouter.routerDelegate,
              builder: (context, child) {
                child = _easyLoadingInit(context, child);
                return fontBuilder(context, child);
              },
              title: 'Passengers Shop',
              //useInheritedMediaQuery: true,
              theme: lightTheme,
            );
          },
        );
      },
    );
  }
}
