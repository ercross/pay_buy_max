import 'package:flutter/material.dart';

class ForgotPasswordProgressProvider extends ChangeNotifier {
  int _currentStage;
  String _submittedEmail;
  String _verificationCode;
  String _password;
  String _confirmPassword;

  ForgotPasswordProgressProvider()
      : _currentStage = 0,
        _submittedEmail = "",
        _password = "",
        _confirmPassword = "",
        _verificationCode = "";

  int get currentStage => _currentStage;
  String get submittedEmail => _submittedEmail;
  String get verificationCode => _verificationCode;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  /// [nextStage] only handles changing the [currentStage].
  /// Navigation should be handled within the widget classes
  void nextStage() {
    if (_currentStage != 2) {
      _currentStage++;
      notifyListeners();
    }
  }

  /// [previousStage] only handles changing the [currentStage].
  /// Navigation should be handled within the widget classes
  void previousStage() {
    if (_currentStage != 0) {
      _currentStage--;
      notifyListeners();
    }
  }

  void resetPassword(String password) {
    _password = password;
  }

  void resetConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  void submitPassword() {}

  void resetVerificationCode(String code) {
    _verificationCode = code;
  }

  void submitVerificationCode() {
    print("Inside submit verificiation. _currentStage is $_currentStage");

    nextStage();
  }

  void resetEmail(String email) {
    _submittedEmail = email;
  }

  void submitEmail() {
    nextStage();
  }
}
