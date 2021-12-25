import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../home_page.dart';
import '/helpers/text_field_validators.dart';
import '../../../main.dart';
import '../../../style_sheet.dart';
import '../../widgets/authentication_text_field.dart';
import '../../widgets/horizontal_bar.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInPage extends StatefulWidget {
  SignInPage();

  static const String route = "/sign-in";

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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

    return BlankPage.withoutSafeArea(
        child: Container(
      color: StyleSheet.primaryColor.withOpacity(0.09),
      alignment: Alignment.center,
      child: SizedBox(
        height: pageHeight * 0.9,
        width: pageWidth * 0.9,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: pageHeight * 0.08),
              Image.asset(
                "assets/images/launcher_icon.png",
                fit: BoxFit.contain,
                height: pageHeight * 0.11,
                width: pageWidth * 0.3,
              ),
              SizedBox(height: pageHeight * 0.02),
              Text("Enter your credentials to gain access",
                  textAlign: TextAlign.center, style: StyleSheet.black14w400),
              SizedBox(height: pageHeight * 0.05),
              AuthenticationTextField(
                  fieldName: "Email",
                  leading: Icons.email_rounded,
                  onSaved: (value) => {
                        if (Validator.isValidEmail(value ?? ""))
                          _credentials.putIfAbsent("email", () => value ?? "")
                        else
                          AppOverlay.snackbar(
                              message:
                                  "invalid email address. please enter a valid email address")
                      },
                  renderHeight: pageHeight * 0.11,
                  renderWidth: contentWidth),
              SizedBox(height: pageHeight * 0.04),
              PasswordAuthField(
                  onSaved: (value) {
                    if (value.isEmpty) {
                      AppOverlay.snackbar(
                          message: "please enter your password");
                    } else
                      _credentials.putIfAbsent("password", () => value);
                  },
                  height: pageHeight * 0.065,
                  width: contentWidth),
              SizedBox(height: pageHeight * 0.07),
              HorizontalBar.button(
                  height: pageHeight * 0.065,
                  width: contentWidth,
                  child: Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: StyleSheet.white15w400,
                  ),
                  onPressed:(){
                    _saveCredentials(context);
                  }),
              SizedBox(height: pageHeight * 0.04),
              _ForgotPasswordText(),
              _SignUpPrompt()
            ],
          ),
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
  }

  Future<void> _signUp(BuildContext context) async {
    showLoadingDialog(context);

    final response = await signUp();
    Navigator.pop(context);
    if(response.status == true){
      //AppOverlay.snackbar(message: "Welcome");
      Navigator.of(context).pushNamed(HomePage.route,arguments: response);
    }else{
      if(response.message == null){
        AppOverlay.snackbar(message: "An Error Occurred!. Please Try Again");
      }else{
        if(response.message!.isEmpty){
          AppOverlay.snackbar(message: "An Error Occurred!. Please Try Again");
        }else{
          AppOverlay.snackbar(message: response.message.toString());
        }
      }
    }
  }

  Future<SignInResponseEntity> signUp() async{
    String url = 'https://paybuymax.com/api/signin';
    final response = await http.post(Uri.parse(url), body: {'email': _credentials["email"], 'password': _credentials["password"]});
    return SignInResponseEntity().fromJson(json.decode(response.body));
  }

  void showLoadingDialog(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Signing you in. Please wait"),
          )
        ],
      ),
    );

    showDialog(barrierDismissible: false, context:context, builder: (BuildContext context){
      return alertDialog;
    });
  }

}

class _ForgotPasswordText extends StatelessWidget {
  const _ForgotPasswordText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Forgot your password?",
              style:
                  StyleSheet.black14w500.copyWith(fontWeight: FontWeight.w300)),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(ForgotPasswordPage.route),
              child: Text("Reset Password",
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
          Text("Don't have an account?",
              style:
                  StyleSheet.black14w500.copyWith(fontWeight: FontWeight.w300)),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(SignUpPage.route),
              child: Text("SIGN UP", style: StyleSheet.gold14w400)),
        ],
      ),
    );
  }

}
