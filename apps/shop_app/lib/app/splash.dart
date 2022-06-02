import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/generated/locale_keys.g.dart';
import 'package:simple_animations/simple_animations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const path = '/splash';
  static const name = 'splash_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tween2 = MultiTween<DefaultAnimationProperties>()
      ..add(
        DefaultAnimationProperties.offset,
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ),
        const Duration(seconds: 1),
        Curves.easeInCubic,
      )
      ..add(
        DefaultAnimationProperties.scale,
        Tween<double>(begin: 0.2, end: 1),
        const Duration(seconds: 1),
        Curves.easeOutCirc,
      );
    var scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.onSurface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PlayAnimation<MultiTweenValues<DefaultAnimationProperties>>(
              tween: tween2,
              child: SvgPicture.asset(
                Images.appLogo,
                width: 82.r,
                color: scheme.surface,
              ),
              builder: (context, child, animation) => Transform.scale(
                scale: animation.get(DefaultAnimationProperties.scale),
                child: FractionalTranslation(
                  translation: animation.get(DefaultAnimationProperties.offset),
                  child: child,
                ),
              ),
            ),
            Center(
                child: YouText.titleMedium(
              LocaleKeys.splash_text.tr(),
              style: TextStyle(color: scheme.surface),
            ))
          ],
        ),
      ),
    );
  }
}
