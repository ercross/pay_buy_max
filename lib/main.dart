import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_cupertino_app.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pay_buy_max/views/screens/exchange_screens/exchange_screen.dart';
import 'package:pay_buy_max/views/screens/home_page.dart';
import 'package:pay_buy_max/views/screens/payment_screen.dart';
import 'package:pay_buy_max/views/screens/wallet_screens/wallet_screen.dart';

import 'views/screens/chat_support_screen.dart';
import 'views/screens/authentication_screens/forgot_password_screen.dart';
import 'views/screens/authentication_screens/sign_in_screen.dart';
import 'views/screens/authentication_screens/sign_up_screen.dart';
import 'views/screens/landing_screen_scaffold/landing_screen_scaffold.dart';
import 'views/screens/onboarding_screen.dart';
import 'views/screens/secondary_splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFFFFFFF)));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(PayBuyMax());
}

class PayBuyMax extends StatelessWidget {
  static const int _duration = 750;

  final List<GetPage<dynamic>> _pages = [
    GetPage(
      name: SecondarySplashScreen.route,
      page: () => SecondarySplashScreen(),
    ),
    GetPage(
        name: OnboardingPage.route,
        page: () => OnboardingPage(),
        curve: Curves.easeInCubic,
        transitionDuration: Duration(milliseconds: _duration),
        transition: Transition.size),
    GetPage(
        name: SignUpPage.route,
        page: () => SignUpPage(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition: Transition.fadeIn),
    GetPage(
        name: SignInPage.route,
        page: () => SignInPage(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition: Transition.fadeIn),
    GetPage(
        name: ForgotPasswordPage.route,
        page: () => ForgotPasswordPage(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition: Transition.fadeIn),
    GetPage(
        name: ChatSupport.route,
        page: () => ChatSupport(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition: Transition.size),
    GetPage(
        name: PaymentPage.route,
        page: () => PaymentPage(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition: Transition.size),
    GetPage(
        name: HomePage.route,
        page: () => HomePage(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition: Transition.upToDown),
    GetPage(
        name: WalletScreen.route,
        page: () => WalletScreen(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition:  Transition.rightToLeft),
    GetPage(
        name: ExchangeScreen.route,
        page: () => ExchangeScreen(),
        curve: Curves.easeIn,
        transitionDuration: Duration(milliseconds: _duration),
        transition:  Transition.rightToLeft),
  ];

  static const String _entry = HomePage.route;

  @override
  Widget build(BuildContext context) => Platform.isAndroid
      ? GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: _entry,
          getPages: _pages)
      : GetCupertinoApp(
          debugShowCheckedModeBanner: false,
          initialRoute: _entry,
          getPages: _pages,
        );
}

/// BlankPage builds the right platform-dependent root widget,
/// CupertinoPageScaffold for iOS and Scaffold for Android.
class BlankPage extends StatelessWidget {
  final Widget child;
  final bool _withSafeArea;
  const BlankPage({required this.child}) : _withSafeArea = false;

  const BlankPage.withoutSafeArea({required this.child}) : _withSafeArea = true;

  @override
  Widget build(BuildContext context) {
    return _withSafeArea
        ? Platform.isIOS
            ? CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                child: GestureDetector(
                    child: child,
                    onTap: () => WidgetsBinding
                        .instance?.focusManager.primaryFocus
                        ?.unfocus()))
            : Scaffold(
                resizeToAvoidBottomInset: false,
                body: GestureDetector(
                    child: child,
                    onTap: () => WidgetsBinding
                        .instance?.focusManager.primaryFocus
                        ?.unfocus()))
        : Platform.isIOS
            ? CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                child: SafeArea(
                  child: GestureDetector(
                      child: child,
                      onTap: () => WidgetsBinding
                          .instance?.focusManager.primaryFocus
                          ?.unfocus()),
                ))
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
