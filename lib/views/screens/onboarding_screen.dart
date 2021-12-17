import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../main.dart';
import '/views/screens/authentication_screens/sign_up_screen.dart';
import '/views/widgets/horizontal_bar.dart';

import '../../style_sheet.dart';

class _OnboardingPageController extends GetxController {
  RxInt _currentIndex = RxInt(0);

  RxInt get currentIndex => _currentIndex;

  changeCurrentIndex(int value) {
    _currentIndex = RxInt(value);
    update();
  }

  next() {
    _currentIndex++;
    update();
  }

  previous() {
    _currentIndex--;
    update();
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage();

  static const String route = '/onboarding';

  static const String _base = "assets/images/";
  static const List<String> _imagesUrls = [
    _base + "onboarding1.png",
    _base + "onboarding2.png",
    _base + "onboarding3.png"
  ];
  static const List<String> _titles = [
    "Get your money working",
    "Secured Transaction",
    "We want to see your grow"
  ];

  static const List<String> _contents = [
    "At PayBuyMax, we offer you an easy way to exchange your cryptocurrencies" +
        " and funds for real cash into your local bank account.",
    "At PayBuyMax, we offer you an easy way to exchange your cryptocurrencies" +
        " and funds for real cash into your local bank account.",
    "At PayBuyMax, we offer you an easy way to exchange your cryptocurrencies" +
        " and funds for real cash into your local bank account."
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.width;
    final _OnboardingPageController state =
        Get.put<_OnboardingPageController>(_OnboardingPageController());
    final CarouselController slideControl = CarouselController();
    return BlankPage.withoutSafeArea(
        child: Container(
      height: pageHeight,
      width: pageWidth,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration:
          BoxDecoration(color: StyleSheet.primaryColor.withOpacity(0.09)),
      child: Column(
        children: [
          SizedBox(width: pageWidth, child: _Navigator(slideControl)),
          SizedBox(
            height: pageHeight * 0.09,
          ),
          CarouselSlider.builder(
              itemCount: _imagesUrls.length,
              carouselController: slideControl,
              options: CarouselOptions(
                height: pageHeight * 0.4,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                onPageChanged: (index, cause) =>
                    state.changeCurrentIndex(index),
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (_, __, index) => Image.asset(
                    _imagesUrls[index],
                    fit: BoxFit.contain,
                    height: pageHeight * 0.4,
                    width: pageWidth,
                  )),
          SizedBox(
            height: pageHeight * 0.04,
          ),
          Obx(
            () => Text(_titles[state.currentIndex.value],
                textAlign: TextAlign.center, style: StyleSheet.gold15w600),
          ),
          SizedBox(
            height: pageHeight * 0.03,
          ),
          Obx(
            () => SizedBox(
              width: pageWidth * 0.85,
              child: Text(_contents[state.currentIndex.value],
                  textAlign: TextAlign.center,
                  style: StyleSheet.grey14w500.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w300)),
            ),
          ),
          SizedBox(
            height: pageHeight * 0.09,
          ),
          HorizontalBar.button(
              child: Text("Get Started",
                  textAlign: TextAlign.center, style: StyleSheet.white15w500),
              height: pageHeight * 0.06,
              width: pageWidth * 0.9,
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(SignUpPage.route)),
          SizedBox(
            height: pageHeight * 0.02,
          ),
        ],
      ),
    ));
  }
}

class _Navigator extends StatelessWidget {
  final CarouselController slideController;
  const _Navigator(this.slideController);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_OnboardingPageController>(
      builder: (state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Platform.isIOS
              ? CupertinoButton(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: StyleSheet.primaryColor.withOpacity(0.6),
                  ),
                  onPressed: () => slideController.previousPage(),
                )
              : IconButton(
                  onPressed: () => slideController.previousPage(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: StyleSheet.primaryColor.withOpacity(0.6),
                  )),
          _ProgressIndicator(active: state.currentIndex.value),
          Platform.isIOS
              ? CupertinoButton(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: StyleSheet.primaryColor.withOpacity(0.6),
                  ),
                  onPressed: () => slideController.nextPage())
              : IconButton(
                  onPressed: () => slideController.nextPage(),
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: StyleSheet.primaryColor.withOpacity(0.6),
                  )),
        ],
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int active;
  const _ProgressIndicator({required this.active});

  @override
  Widget build(BuildContext context) {
    final Widget space = SizedBox(
      width: 10,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Indicator(index: 0, active: active),
        space,
        _Indicator(index: 1, active: active),
        space,
        _Indicator(index: 2, active: active),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final int index;
  final int active;
  const _Indicator({required this.index, required this.active});

  @override
  Widget build(BuildContext context) {
    return index == active
        ? _ActiveIndicator(index)
        : _InactiveIndicator(index);
  }
}

class _ActiveIndicator extends StatelessWidget {
  final int index;
  const _ActiveIndicator(this.index);

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width * 0.04;
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: StyleSheet.primaryColor,
      ),
    );
  }
}

class _InactiveIndicator extends StatelessWidget {
  final int index;
  const _InactiveIndicator(this.index);

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width * 0.03;
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: StyleSheet.primaryColor.withOpacity(0.5),
      ),
    );
  }
}
