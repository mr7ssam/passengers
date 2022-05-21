import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/user/presentation/pages/complete_info/complete_info_screen.dart';
import 'package:shop_app/core/app_manger/bloc/app_manger_bloc.dart';
import 'package:shop_app/resources/resources.dart';
import 'package:simple_animations/simple_animations.dart';

class CompleteInfoLandScreen extends StatelessWidget {
  static const path = '/complete-info-land';
  static const name = 'complete-info-land';

  const CompleteInfoLandScreen({Key? key}) : super(key: key);

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: const CompleteInfoLandScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tween2 = MultiTween<DefaultAnimationProperties>()
      ..add(DefaultAnimationProperties.offset,
          Tween(begin: const Offset(1.5, -1.5), end: const Offset(0, 0)))
      ..add(
          DefaultAnimationProperties.scale, Tween<double>(begin: 0.5, end: 1));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onLogoutPressed(context),
          icon: const Icon(PIcons.outline_logout),
        ),
      ),
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
                Images.gift,
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
                  'Congratulations!',
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
              widthFactor: 0.7,
              child: YouText.bodyMedium(
                'You have joined us, we are so glad for that,'
                ' To enable your customers to recognize your store,'
                ' information on it must be completed.',
                textAlign: TextAlign.center,
              ),
            ),
            Space.vM3,
            const FractionallySizedBox(
              widthFactor: 0.7,
              child: YouText.bodyMedium(
                'Or contact us to do that together',
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
                    context.goNamed(CompleteInfoScreen.name);
                  },
                  child: const Text('Complete Information')),
            ),
            PlayAnimation<double>(
              delay: const Duration(seconds: 2),
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (_, child, value) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: TextButton(
                onPressed: () {},
                child: const Text('Contact us'),
                style: TextButton.styleFrom(primary: Colors.black38),
              ),
            ),
            Space.vL1,
          ],
        ),
      ),
    );
  }

  void _onLogoutPressed(BuildContext context) {
    context.read<AppMangerBloc>().add(AppMangerLoggedOut());
  }
}
