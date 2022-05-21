import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_location_picker/generated/l10n.dart' as location_picker;
import 'package:p_design/p_design.dart';
import 'package:shop_app/providers.dart';
import 'package:shop_app/resources/resources.dart';
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
        final appRouter = AppRouter.of(context);
        return ScreenUtilInit(
          builder: (_, __) => MaterialApp.router(
            locale: context.locale,
            localizationsDelegates: [
              ...context.localizationDelegates,
              location_picker.S.delegate,
            ],
            supportedLocales: context.supportedLocales,
            routeInformationParser: appRouter.goRouter.routeInformationParser,
            routerDelegate: appRouter.goRouter.routerDelegate,
            builder: (context, child) {
              EasyLoading.instance
                ..indicatorType = EasyLoadingIndicatorType.ripple
                ..successWidget = SizedBox(
                  width: 0.7.sw,
                  child: SvgPicture.asset(
                    Images.done,
                    height: 64.r,
                  ),
                )
                ..backgroundColor = Theme.of(context).scaffoldBackgroundColor
                ..maskColor = Theme.of(context).scaffoldBackgroundColor
                ..maskType = EasyLoadingMaskType.black
                ..loadingStyle = EasyLoadingStyle.light;
              child = _easyLoadingInit(context, child);
              return fontBuilder(context, child);
            },
            title: 'Passengers Shop',
            //useInheritedMediaQuery: true,
            theme: lightTheme,
          ),
        );
      },
    );
  }
}
