/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIllustrationsGen {
  const $AssetsIllustrationsGen();

  $AssetsIllustrationsFullPageGen get fullPage =>
      const $AssetsIllustrationsFullPageGen();
  $AssetsIllustrationsSmallIllustrationGen get smallIllustration =>
      const $AssetsIllustrationsSmallIllustrationGen();
  $AssetsIllustrationsStartPageGen get startPage =>
      const $AssetsIllustrationsStartPageGen();
}

class $AssetsIllustrationsFullPageGen {
  const $AssetsIllustrationsFullPageGen();

  /// File path: assets/Illustrations/full_page/completed.svg
  String get completed => 'assets/Illustrations/full_page/completed.svg';

  /// File path: assets/Illustrations/full_page/gift.svg
  String get gift => 'assets/Illustrations/full_page/gift.svg';

  /// File path: assets/Illustrations/full_page/lock.svg
  String get lock => 'assets/Illustrations/full_page/lock.svg';

  /// File path: assets/Illustrations/full_page/unlock.svg
  String get unlock => 'assets/Illustrations/full_page/unlock.svg';
}

class $AssetsIllustrationsSmallIllustrationGen {
  const $AssetsIllustrationsSmallIllustrationGen();

  /// File path: assets/Illustrations/small_illustration/medium_clipboard.svg
  String get mediumClipboard =>
      'assets/Illustrations/small_illustration/medium_clipboard.svg';

  /// File path: assets/Illustrations/small_illustration/medium_star.svg
  String get mediumStar =>
      'assets/Illustrations/small_illustration/medium_star.svg';
}

class $AssetsIllustrationsStartPageGen {
  const $AssetsIllustrationsStartPageGen();

  /// File path: assets/Illustrations/start_page/illustration_store_start_page.svg
  String get illustrationStoreStartPage =>
      'assets/Illustrations/start_page/illustration_store_start_page.svg';
}

class Assets {
  Assets._();

  static const $AssetsIllustrationsGen illustrations =
      $AssetsIllustrationsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
