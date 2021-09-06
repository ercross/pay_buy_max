import 'package:flutter/material.dart';
import '../../style_sheet.dart';
import '/main.dart';

import 'onboarding_screen.dart';

class SecondarySplashScreen extends StatefulWidget {
  const SecondarySplashScreen();

  static const String route = "/secondary-splash";

  @override
  _SecondarySplashScreenState createState() => _SecondarySplashScreenState();
}

class _SecondarySplashScreenState extends State<SecondarySplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeIn,
    ));
    _logoAnimationController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlankPage(
        child: Container(
            color: StyleSheet.accentColor.withOpacity(0.09),
            alignment: Alignment.center,
            child: _Multiplexor(_animation)));
  }
}

class _Multiplexor extends StatelessWidget {
  final Animation<double> animation;
  const _Multiplexor(this.animation);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (_, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return _FadeInLogo(animation);
          else
            return OnboardingPage();
        });
  }
}

class _FadeInLogo extends StatelessWidget {
  final Animation<double> animation;
  const _FadeInLogo(this.animation);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double imageHeight = size.height * 0.5;
    final double imageWidth = size.width * 0.6;
    return FadeTransition(
        opacity: animation,
        child: Image.asset("assets/images/splash_screen_logo.png",
            fit: BoxFit.contain, height: imageHeight, width: imageWidth));
  }
}
