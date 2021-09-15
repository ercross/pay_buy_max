import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/screens/chat_support_screen.dart';
import 'views/screens/authentication_screens/forgot_password_screen.dart';
import 'views/screens/authentication_screens/sign_in_screen.dart';
import 'views/screens/authentication_screens/sign_up_screen.dart';
import 'views/screens/landing_screen_scaffold/landing_screen_scaffold.dart';
import 'views/screens/onboarding_screen.dart';
import 'views/screens/secondary_splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(PayBuyMax());
}

class PayBuyMax extends StatelessWidget {
  static const String _title = "PayBuyMax";
  static final bool _isIos = Platform.isIOS;

  static final Map<String, Widget Function(BuildContext)> _routes = {
    SecondarySplashScreen.route: (_) => SecondarySplashScreen(),
    OnboardingPage.route: (_) => OnboardingPage(),
    SignInPage.route: (_) => SignInPage(),
    SignUpPage.route: (_) => SignUpPage(),
    ForgotPasswordPage.route: (_) => ForgotPasswordPage(),
    LandingPageScaffold.route: (_) => LandingPageScaffold(),
    ChatSupport.route: (_) => ChatSupport(),
  };

  static const String _entry = LandingPageScaffold.route;

  @override
  Widget build(BuildContext context) => _isIos ? _IOSRoot() : _AndroidRoot();
}

class _IOSRoot extends StatelessWidget {
  const _IOSRoot();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: BotToastInit(),
      title: PayBuyMax._title,
      initialRoute: PayBuyMax._entry,
      routes: PayBuyMax._routes,
    );
  }
}

class _AndroidRoot extends StatelessWidget {
  const _AndroidRoot();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: BotToastInit(),
      title: PayBuyMax._title,
      initialRoute: PayBuyMax._entry,
      routes: PayBuyMax._routes,
    );
  }
}

/// BlankPage builds the right platform-dependent root widget,
/// CupertinoPageScaffold for iOS and Scaffold for Android.
class BlankPage extends StatelessWidget {
  final Widget child;
  const BlankPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return PayBuyMax._isIos
        ? CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            child: GestureDetector(
                child: child,
                onTap: () => WidgetsBinding.instance?.focusManager.primaryFocus
                    ?.unfocus()))
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: GestureDetector(
                    child: child,
                    onTap: () => WidgetsBinding
                        .instance?.focusManager.primaryFocus
                        ?.unfocus())));
  }
}
