import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../root.dart';

class GetStartedScreen extends StatelessWidget {
  static const path = '/get-started';
  static const name = 'get_started';

  const GetStartedScreen({Key? key}) : super(key: key);

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: const GetStartedScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tween2 = MultiTween<DefaultAnimationProperties>()
      ..add(DefaultAnimationProperties.offset,
          Tween(begin: const Offset(1.5, -1.5), end: const Offset(0, 0)))
      ..add(
          DefaultAnimationProperties.scale, Tween<double>(begin: 0.4, end: 1));
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Space.vXL3,
            PlayAnimation<MultiTweenValues<DefaultAnimationProperties>>(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCirc,
              tween: tween2,
              child: SvgPicture.asset(
                Images.complete,
                width: 256.w,
              ),
              builder: (_, child, value) {
                return Transform.scale(
                  scale: value.get(DefaultAnimationProperties.scale),
                  child: FractionalTranslation(
                    translation: value.get(DefaultAnimationProperties.offset),
                    child: child,
                  ),
                );
              },
            ),
            Space.vM4,
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'It is completed!',
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            Space.vM4,
            const FractionallySizedBox(
              widthFactor: 0.75,
              child: YouText.bodyMedium(
                'Now your customers can see everything that is new for your'
                ' store, share the application to tell your customers that.',
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            PlayAnimation<double>(
              delay: const Duration(seconds: 1),
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (_, child, value) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: TextButton(
                  onPressed: () {
                    context.goNamed(RootScreen.name);
                  },
                  child: const Text('Get Started')),
            ),
            // PlayAnimation<double>(
            //   delay: const Duration(seconds: 2),
            //   duration: const Duration(milliseconds: 600),
            //   tween: Tween<double>(begin: 0, end: 1),
            //   builder: (_, child, value) {
            //     return Opacity(
            //       opacity: value,
            //       child: child,
            //     );
            //   },
            //   child: TextButton(
            //     onPressed: () {},
            //     child: const Text('Contact us'),
            //     style: TextButton.styleFrom(primary: Colors.black38),
            //   ),
            // ),
            Space.vL1,
          ],
        ),
      ),
    );
  }
}
