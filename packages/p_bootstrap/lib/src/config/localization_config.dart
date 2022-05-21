import 'package:flutter/material.dart';

class LocalizationConfig {
  LocalizationConfig({
    this.supportedLocales = const [Locale('ar'), Locale('en')],
    this.fallbackLocale = const Locale('ar'),
    this.startLocale,
    this.useOnlyLangCode = true,
    this.useFallbackTranslations = true,
    this.path = "translations/",
    this.assetLoader,
    this.saveLocale = true,
  });

  final List<Locale> supportedLocales;

  final Locale? fallbackLocale;

  final Locale? startLocale;

  final bool useOnlyLangCode;

  final bool useFallbackTranslations;

  final String path;

  final dynamic assetLoader;

  final bool saveLocale;
}
