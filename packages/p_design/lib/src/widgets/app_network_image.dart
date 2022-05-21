import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.loadStateChanged,
    this.imageRepeat = ImageRepeat.noRepeat,
    this.filterQuality = FilterQuality.low,
    this.clipBehavior = Clip.antiAlias,
    this.enableLoadState = true,
    this.mode = ExtendedImageMode.none,
    this.enableMemoryCache = true,
    this.clearMemoryCacheIfFailed = true,
    this.onDoubleTap,
    this.constraints,
    this.cancelToken,
    this.retries = 3,
    this.timeLimit,
    this.headers,
    this.cache = true,
    this.scale = 1.0,
    this.timeRetry = const Duration(milliseconds: 100),
    this.cacheWidth,
    this.cacheHeight,
    this.isAntiAlias = false,
    this.cacheKey,
    this.compressionRatio,
    this.maxBytes,
    this.cacheRawData = false,
    this.imageCacheName,
    this.cacheMaxAge,
    this.printError = true,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final Color? color;
  final double? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit fit;
  final Alignment alignment;
  final LoadStateChanged? loadStateChanged;
  final ImageRepeat imageRepeat;
  final FilterQuality filterQuality;
  final Clip clipBehavior;
  final bool enableLoadState;
  final ExtendedImageMode mode;
  final bool enableMemoryCache;
  final bool clearMemoryCacheIfFailed;
  final VoidCallback? onDoubleTap;
  final BoxConstraints? constraints;
  final CancellationToken? cancelToken;
  final int retries;
  final Duration? timeLimit;
  final Map<String, String>? headers;
  final bool cache;
  final double scale;
  final Duration timeRetry;
  final int? cacheWidth;
  final int? cacheHeight;
  final bool isAntiAlias;
  final String? cacheKey;
  final bool printError;
  final double? compressionRatio;
  final int? maxBytes;
  final bool cacheRawData;
  final String? imageCacheName;
  final Duration? cacheMaxAge;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      width: width,
      height: width,
      fit: fit,
      cache: cache,
    );
  }
}
