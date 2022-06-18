import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_location_picker/generated/l10n.dart' as location_picker;
import 'package:network_logger/network_logger.dart';
import 'package:p_design/p_design.dart';

import 'providers.dart';
import 'router/router.dart';

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
        final goRouter = appRouter.goRouter;

        return ScreenUtilInit(
          builder: (_, __) {
            return MaterialApp.router(
              localizationsDelegates: const [
                location_picker.S.delegate,
              ],
              routeInformationProvider: goRouter.routeInformationProvider,
              routeInformationParser: goRouter.routeInformationParser,
              routerDelegate: goRouter.routerDelegate,
              builder: (context, child) {
                EasyLoading.instance
                  ..indicatorType = EasyLoadingIndicatorType.ripple
                  ..successWidget = SizedBox(
                    width: 0.7.sw,
                    child: SvgPicture.asset(
                      Images.done,
                      package: kDesignPackageName,
                      height: 64.r,
                    ),
                  )
                  ..dismissOnTap = true
                  ..backgroundColor = Theme.of(context).scaffoldBackgroundColor
                  ..maskColor = Theme.of(context).scaffoldBackgroundColor
                  ..maskType = EasyLoadingMaskType.black
                  ..loadingStyle = EasyLoadingStyle.light;
                child = _easyLoadingInit(context, child);
                NetworkLoggerOverlay.attachTo(
                  context,
                );

                return fontBuilder(context, child);
              },
              title: 'Customer Shop',
              theme: lightTheme,
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
