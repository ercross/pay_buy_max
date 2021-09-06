import 'package:flutter/material.dart';

import '../../../helpers/text_field_validators.dart';
import '../../../main.dart';
import '../../../style_sheet.dart';
import '../../widgets/authentication_text_field.dart';
import '../../widgets/horizontal_bar.dart';
import 'sign_in_screen.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage();

  static const String route = "/sign-up";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late GlobalKey<FormState> _formKey;

  Map<String, String> _credentials = {};

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.width;
    final double contentWidth = pageWidth * 0.75;
    final double formHeight = pageWidth * 0.13;

    return BlankPage(
        child: Container(
      alignment: Alignment.center,
      color: StyleSheet.primaryColor.withOpacity(0.09),
      child: SizedBox(
        height: pageHeight * 0.9,
        width: pageWidth * 0.9,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/launcher_icon.png",
                fit: BoxFit.fill,
                height: pageHeight * 0.11,
                width: pageWidth * 0.3,
              ),
              Text("Sign up to get started",
                  textAlign: TextAlign.center, style: StyleSheet.black14w500),
              SizedBox(height: pageHeight * 0.01),
              AuthenticationTextField(
                  excludeFieldName: true,
                  fieldName: "Email",
                  leading: Icons.email_rounded,
                  validator: (value) => Validator.validateEmail(value ?? ""),
                  onSaved: (value) => _onFieldsSaved(value ?? "", "email"),
                  renderHeight: formHeight,
                  renderWidth: contentWidth),
              SizedBox(height: pageHeight * 0.01),
              AuthenticationTextField(
                  excludeFieldName: true,
                  fieldName: "Phone Number",
                  leading: Icons.phone_android_rounded,
                  isDigits: true,
                  validator: (value) =>
                      Validator.validatePhoneNumber(value ?? ""),
                  onSaved: (value) => _onFieldsSaved(value ?? "", "phone"),
                  renderHeight: formHeight,
                  renderWidth: contentWidth),
              SizedBox(height: pageHeight * 0.01),
              AuthenticationTextField(
                  excludeFieldName: true,
                  fieldName: "Password",
                  leading: Icons.lock_rounded,
                  isPassword: true,
                  validator: (value) => _validateFields(value, "password"),
                  onSaved: (value) => _onFieldsSaved(value ?? "", "password"),
                  renderHeight: formHeight,
                  renderWidth: contentWidth),
              SizedBox(height: pageHeight * 0.01),
              AuthenticationTextField(
                  excludeFieldName: true,
                  fieldName: "Confirm Password",
                  leading: Icons.lock_rounded,
                  isPassword: true,
                  validator: (value) =>
                      _validateFields(value, "confirm password"),
                  onSaved: (value) =>
                      _onFieldsSaved(value ?? "", "confirm password"),
                  renderHeight: formHeight,
                  renderWidth: contentWidth),
              SizedBox(height: pageHeight * 0.02),
              HorizontalBar.button(
                  height: pageHeight * 0.07,
                  width: contentWidth,
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: StyleSheet.white15w500,
                  ),
                  onPressed: _saveCredentials),
              _TermsAndConditionDisclaimer(),
              _SignUpPrompt()
            ],
          ),
        ),
      ),
    ));
  }

  String? _validateFields(String? value, String fieldName) {
    if (value == null || value.isEmpty)
      return "please enter a valid $fieldName";
    return null;
  }

  void _onFieldsSaved(String value, String key) {
    if (_credentials.containsKey(key)) _credentials.remove(key);
    if (value.isEmpty) return;
    _credentials.putIfAbsent(key, () => value);
  }

  void _saveCredentials() {
    if (_formKey.currentState!.validate()) _formKey.currentState!.save();
  }
}

class _TermsAndConditionDisclaimer extends StatelessWidget {
  const _TermsAndConditionDisclaimer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("By signing up, you agree with our",
              style:
                  StyleSheet.black14w500.copyWith(fontWeight: FontWeight.w300)),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
              onTap: () {},
              child: Text("Terms & Conditions",
                  style: StyleSheet.black15w400Underlined)),
        ],
      ),
    );
  }
}

class _SignUpPrompt extends StatelessWidget {
  const _SignUpPrompt();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account?",
              style:
                  StyleSheet.black14w500.copyWith(fontWeight: FontWeight.w300)),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(SignInPage.route),
              child: Text("SIGN IN", style: StyleSheet.gold14w600)),
        ],
      ),
    );
  }
}
