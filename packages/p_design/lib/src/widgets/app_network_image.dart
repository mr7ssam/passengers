import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_loading.dart';

class AppNetworkImage extends StatefulWidget {
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
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      width: widget.width,
      height: widget.width,
      fit: widget.fit,
      cache: widget.cache,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            _controller.reset();
            return const AppLoading();

          case LoadState.completed:
            _controller.forward();
            return FadeTransition(
              opacity: _controller,
              child: ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: widget.width,
                height: widget.height,
              ),
            );
          case LoadState.failed:
            log(state.lastException.toString(),stackTrace: state.lastStack);
            _controller.reset();
            return IconButton(
              icon: const Icon(Icons.refresh_outlined),
              onPressed: (){
                state.reLoadImage();
              },
            );
        }
      },
    );
  }
}
