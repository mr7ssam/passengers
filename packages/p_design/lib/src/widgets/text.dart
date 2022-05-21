import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/material.dart';

enum YouTextStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

class YouText extends Text {
  const YouText._(
    String text, {
    Key? key,
    required this.textStyle,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          overflow: textOverflow,
        );

  const YouText.displayLarge(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.displayLarge,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.displayMedium(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.displayMedium,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.displaySmall(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.displaySmall,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.headlineLarge(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.headlineLarge,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.headlineMedium(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.headlineMedium,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.headlineSmall(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.headlineSmall,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.titleLarge(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.titleLarge,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.titleMedium(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.titleMedium,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.titleSmall(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.titleSmall,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.bodyLarge(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.bodyLarge,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.bodyMedium(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.bodyMedium,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.bodySmall(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.bodySmall,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.labelLarge(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.labelLarge,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.labelMedium(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.labelMedium,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  const YouText.labelSmall(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? textOverflow,
    int? maxLines,
    Locale? locale,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    ui.TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) : this._(
          text,
          textStyle: YouTextStyle.labelSmall,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  final YouTextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? style;
    switch (textStyle) {
      case YouTextStyle.displayLarge:
        style = textTheme.displayLarge;
        break;
      case YouTextStyle.displayMedium:
        style = textTheme.displayMedium;
        break;
      case YouTextStyle.displaySmall:
        style = textTheme.displaySmall;
        break;
      case YouTextStyle.headlineLarge:
        style = textTheme.headlineLarge;
        break;
      case YouTextStyle.headlineMedium:
        style = textTheme.headlineMedium;
        break;
      case YouTextStyle.headlineSmall:
        style = textTheme.headlineSmall;
        break;
      case YouTextStyle.titleLarge:
        style = textTheme.titleLarge;
        break;
      case YouTextStyle.titleMedium:
        style = textTheme.titleMedium;
        break;
      case YouTextStyle.titleSmall:
        style = textTheme.titleSmall;
        break;
      case YouTextStyle.bodyLarge:
        style = textTheme.bodyLarge;
        break;
      case YouTextStyle.bodyMedium:
        style = textTheme.bodyMedium;
        break;
      case YouTextStyle.bodySmall:
        style = textTheme.bodySmall;
        break;
      case YouTextStyle.labelLarge:
        style = textTheme.labelLarge;
        break;
      case YouTextStyle.labelMedium:
        style = textTheme.labelMedium;
        break;
      case YouTextStyle.labelSmall:
        style = textTheme.labelSmall;
        break;
    }
    return DefaultTextStyle.merge(
      style: style ?? const TextStyle(),
      child: Builder(builder: (context) => super.build(context)),
    );
  }
}
