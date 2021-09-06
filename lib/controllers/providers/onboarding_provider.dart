import 'package:flutter/material.dart';

class OnboardingPageContentProvider extends ChangeNotifier {
  late int _activeIndex;

  OnboardingPageContentProvider() : _activeIndex = 1;

  int get activeIndex => _activeIndex;

  void previous() {
    if (_activeIndex == 0) {
      _activeIndex = 2;
      notifyListeners();
    } else {
      _activeIndex--;
      notifyListeners();
    }
  }

  void next() {
    if (_activeIndex == 2) {
      _activeIndex = 0;
      notifyListeners();
    } else {
      _activeIndex++;
      notifyListeners();
    }
  }
}
