import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/views/screens/home_page.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/text_field_validators.dart';
import '../../../main.dart';
import '../../../style_sheet.dart';
import '../../widgets/authentication_text_field.dart';
import '../../widgets/horizontal_bar.dart';
import '../../widgets/overlays.dart';
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
    final double contentWidth = pageWidth * 0.8;

    final Widget space = SizedBox(height: pageHeight * 0.04);

    return BlankPage.withoutSafeArea(
        child: Container(
      alignment: Alignment.center,
      color: StyleSheet.primaryColor.withOpacity(0.09),
      padding: EdgeInsets.fromLTRB(
          pageWidth * 0.1,
          MediaQuery.of(context).padding.top + (pageHeight * 0.08),
          pageWidth * 0.1,
          0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
            Image.asset(
              "assets/images/launcher_icon.png",
              fit: BoxFit.contain,
              height: pageHeight * 0.11,
              width: pageWidth * 0.3,
            ),
            space,
            Text("Sign up to get started", textAlign: TextAlign.center, style: StyleSheet.black14w500),
            SizedBox(height: pageHeight * 0.04),
            AuthenticationTextField(
                fieldName: "Email",
                leading: Icons.email_rounded,
                onSaved: (value) => {
                      if (Validator.isValidEmail(value ?? ""))
                        _credentials["email"] = value ?? ""
                      else
                        AppOverlay.snackbar(message: "Invalid email address. please enter a valid email address")
                    },
                renderHeight: pageHeight * 0.11,
                renderWidth: contentWidth),
            space,
            PasswordAuthField(
                onSaved: (value) {
                  if (value.isEmpty) {
                    AppOverlay.snackbar(message: "Please enter your password");
                  } else{
                    if(value.length>8){
                      _credentials["password"] = value;
                    }else{
                      AppOverlay.snackbar(message: "Password Length Is Too Short");
                    }
                  }
                },
                height: pageHeight * 0.065,
                width: contentWidth),
            SizedBox(height: pageHeight * 0.07),
            HorizontalBar.button(
                height: pageHeight * 0.065,
                width: contentWidth,
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: StyleSheet.white15w400,
                ),
                onPressed: (){
                  _saveCredentials(context);
                }),
            space,
            _TermsAndConditionDisclaimer(),
            SizedBox(height: pageHeight * 0.01),
            _SignUpPrompt()
          ],
        ),
      ),
    ));

  }

  void _saveCredentials(BuildContext context) {
    _credentials.clear();
    _formKey.currentState!.save();
    _formKey.currentState!.validate();
    if(!(_credentials["email"] == null || _credentials["password"] == null)){
      if(_credentials["email"]!.isNotEmpty && _credentials["password"]!.isNotEmpty){
        if(_credentials["password"]!.length>=8){
          _signUp(context);
        }
      }
    }
   // Navigator.of(context).pushNamed(HomePage.route);
  }

  Future<void> _signUp(BuildContext context) async {
    showLoadingDialog(context);

    final response = await signUp();
    Navigator.pop(context);
    if(response.status == true){
      AppOverlay.snackbar(message: "Account Creation Successful. Please Sign In.");
      Navigator.of(context).pushNamed(SignInPage.route);
    }else{
      if(response.message == null){
        AppOverlay.snackbar(message: "An Error Occurred!. Please Try Again");
      }else{
        AppOverlay.snackbar(message: response.message.toString());
      }
    }
  }

  Future<SignUpResponseEntity> signUp() async{
    String url = 'https://paybuymax.com/api/signup';
    final response = await http.post(Uri.parse(url), body: {'email': _credentials["email"], 'password': _credentials["password"]});
    return SignUpResponseEntity().fromJson(json.decode(response.body));
  }

  showLoadingDialog(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Creating Account"),
          )
        ],
      ),
    );

    showDialog(barrierDismissible: false, context:context,
      builder: (BuildContext context){
        return alertDialog;
      });
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
              child: Text("SIGN IN", style: StyleSheet.gold14w400)),
        ],
      ),
    );
  }
}
