import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import 'config/localization_config.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent(${event.runtimeType}, $event)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  LocalizationConfig? localizationConfig,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          localizationConfig != null
              ? await _easyLocalization(builder, localizationConfig)
              : await builder(),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

Future<EasyLocalization> _easyLocalization(FutureOr<Widget> Function() builder,
    LocalizationConfig localizationConfig) async {
  await EasyLocalization.ensureInitialized();
  return EasyLocalization(
    child: await builder(),
    supportedLocales: localizationConfig.supportedLocales,
    fallbackLocale: localizationConfig.fallbackLocale,
    assetLoader: localizationConfig.assetLoader,
    useOnlyLangCode: localizationConfig.useOnlyLangCode,
    saveLocale: localizationConfig.saveLocale,
    startLocale: localizationConfig.startLocale,
    useFallbackTranslations: localizationConfig.useFallbackTranslations,
    path: localizationConfig.path,
  );
}
