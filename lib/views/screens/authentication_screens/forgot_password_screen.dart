import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import 'package:provider/provider.dart';
import '../../../controllers/providers/forgot_password_progress_provider.dart';
import '/main.dart';
import '/views/screens/authentication_screens/sign_up_screen.dart';

import '../../../style_sheet.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage();

  static const String route = "/forgot-password";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordProgressProvider>(
        create: (context) => ForgotPasswordProgressProvider(),
        child: _ForgotPasswordPage());
  }
}

class _ForgotPasswordPage extends StatelessWidget {
  const _ForgotPasswordPage();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.width;
    return BlankPage.withoutSafeArea(
        child: Container(
      height: pageHeight,
      width: pageWidth,
      color: StyleSheet.primaryColor.withOpacity(0.09),
      child: Column(
        children: [
          _AppBar(
              renderHeight: pageHeight * 0.3, renderWidth: pageWidth * 0.951),
          SizedBox(
            height: pageHeight * 0.06,
          ),
          _Content(),
          SizedBox(
            height: pageHeight * 0.15,
          )
        ],
      ),
    ));
  }
}

class _Content extends StatelessWidget {
  _Content();

  final List<Widget> _stages = [
    _SendEmailStage(),
    _VerifyCodeStage(),
    _ChangePasswordStage()
  ];

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordProgressProvider state = Provider.of(context);
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 750),
        child: _stages[state.currentStage]);
  }
}

class _SendEmailStage extends StatelessWidget {
  _SendEmailStage();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.height;
    final ForgotPasswordProgressProvider state =
        Provider.of(context, listen: false);
    return Column(
      children: [
        _TitleAndBodyTexts(
            renderHeight: pageHeight * 0.13,
            title: "Forgot Password?",
            body: "Enter the email address associated with your account"),
        _ContentBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: pageHeight * 0.015,
            ),
            _TextField.forEmail(
              renderHeight: pageHeight * 0.09,
              onChanged: (email) {
                state.resetEmail(email);
              },
            ),
            SizedBox(
              height: pageHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Send",
                    style: StyleSheet.black16w400.copyWith(fontSize: 18)),
                _SendButton(
                    width: pageWidth * 0.12,
                    height: pageHeight * 0.07,
                    onPressed: () => _onSubmitted(state))
              ],
            )
          ],
        ))
      ],
    );
  }

  void _onSubmitted(ForgotPasswordProgressProvider state) {
    if (state.submittedEmail.isEmpty) {
      AppOverlay.snackbar(message: "Please enter a valid email");
      return;
    }
    if (_isValidEmail(state.submittedEmail)) {
      state.submitEmail();
      return;
    } else
      AppOverlay.snackbar(title: "", message: "Please enter a valid email");
  }

  bool _isValidEmail(String email) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email))
      return true;
    else
      return false;
  }
}

class _SendButton extends StatelessWidget {
  final void Function() onPressed;
  final double height;
  final double width;
  const _SendButton(
      {required this.width, required this.height, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [StyleSheet.accentColor, StyleSheet.primaryColor],
              stops: [0.1, 0.9],
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _TextField extends StatefulWidget {
  final double renderHeight;
  final String fieldTitle;
  final String hint;
  final void Function(String)? onChanged;

  const _TextField(
      {required this.renderHeight,
      required this.onChanged,
      required this.fieldTitle,
      required this.hint});

  const _TextField.forEmail(
      {required this.renderHeight, required this.onChanged})
      : hint = "youremail@example.com",
        fieldTitle = "Email";

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.renderHeight,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.fieldTitle, style: StyleSheet.grey13w300),
          TextField(
            textAlignVertical: TextAlignVertical.bottom,
            style: StyleSheet.black14w500,
            controller: _controller,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: StyleSheet.black14w400,
            ),
          )
        ],
      ),
    );
  }
}

class _TitleAndBodyTexts extends StatelessWidget {
  final String title;
  final String body;

  /// renderHeight isn't obtained through mediaQuery
  /// because different callers might have different height need.
  final double renderHeight;
  const _TitleAndBodyTexts(
      {required this.renderHeight, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final double textWidth = MediaQuery.of(context).size.width * 0.7;
    return SizedBox(
      height: renderHeight,
      width: textWidth,
      child: Column(
        children: [
          Text(title,
              textAlign: TextAlign.center, style: StyleSheet.black20w500),
          Text(body, textAlign: TextAlign.center, style: StyleSheet.grey13w300)
        ],
      ),
    );
  }
}

class _VerifyCodeStage extends StatelessWidget {
  _VerifyCodeStage();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.height;
    final ForgotPasswordProgressProvider state =
        Provider.of(context, listen: false);
    return Column(
      children: [
        _TitleAndBodyTexts(
            renderHeight: pageHeight * 0.13,
            title: "Verification",
            body: "Enter the verification code sent to your email address"),
        _ContentBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: pageHeight * 0.015,
            ),
            _TextField(
              fieldTitle: "Code",
              hint: "123456",
              renderHeight: pageHeight * 0.09,
              onChanged: (code) {
                state.resetVerificationCode(code);
              },
            ),
            SizedBox(
              height: pageHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Verify Code",
                        style: StyleSheet.black16w400.copyWith(fontSize: 18)),
                    TextButton(
                      onPressed: _resendCode,
                      child: Text("Resend Code",
                          style: StyleSheet.black15w400Underlined),
                    )
                  ],
                ),
                _SendButton(
                    width: pageWidth * 0.12,
                    height: pageHeight * 0.07,
                    onPressed: () => _onSubmitted(state))
              ],
            )
          ],
        ))
      ],
    );
  }

  void _onSubmitted(ForgotPasswordProgressProvider state) {
    if (state.verificationCode.isEmpty || state.verificationCode.length < 6) {
      AppOverlay.snackbar(message: "Please enter a valid code");
      return;
    }
    state.submitVerificationCode();
  }

  void _resendCode() {
    AppOverlay.snackbar(message: "Verification code sent");
  }
}

class _ChangePasswordStage extends StatelessWidget {
  _ChangePasswordStage();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.height;
    final ForgotPasswordProgressProvider state =
        Provider.of(context, listen: false);
    return Column(
      children: [
        _TitleAndBodyTexts(
            renderHeight: pageHeight * 0.13,
            title: "Set New Password",
            body:
                "You can now set new password to secure your access to the account"),
        _ContentBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: pageHeight * 0.015,
            ),
            _TextField(
              fieldTitle: "Password",
              hint: "********",
              renderHeight: pageHeight * 0.09,
              onChanged: (email) {
                state.resetPassword(email);
              },
            ),
            SizedBox(
              height: pageHeight * 0.08,
            ),
            Align(
              alignment: Alignment.center,
              child: _SendButton(
                  width: pageWidth * 0.15,
                  height: pageHeight * 0.06,
                  onPressed: () => _onSubmitted(state, context)),
            )
          ],
        ))
      ],
    );
  }

  void _onSubmitted(
      ForgotPasswordProgressProvider state, BuildContext context) {
    // if (state.password.compareTo(state.confirmPassword) != 0) {
    //   AppOverlay.snackbar(message:  "the passwords do not match");
    //   return;
    // }
    state.submitPassword();
    AppOverlay.snackbar(
      message: "SUCCESS!",
    );
    Navigator.of(context).pushReplacementNamed(SignUpPage.route);
  }
}

class _ContentBox extends StatelessWidget {
  final Widget child;
  const _ContentBox({required this.child});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double boxHeight = size.height * 0.3;
    final double boxWidth = size.width * 0.9;
    return Container(
      height: boxHeight,
      width: boxWidth,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: boxWidth * 0.05, vertical: boxHeight * 0.04),
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: kElevationToShadow[8],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final double renderHeight;
  final double renderWidth;
  const _AppBar({required this.renderHeight, required this.renderWidth});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordProgressProvider state =
        Provider.of(context, listen: false);
    return SizedBox(
      width: renderWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 12),
            child: IconButton(
                onPressed: () {
                  if (state.currentStage != 0) {
                    state.previousStage();
                  } else
                    Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: Colors.black87, size: 28)),
          ),
          SizedBox(
            width: renderWidth * 0.11,
          ),
          _Avatar(renderHeight: renderHeight, renderWidth: renderWidth),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final double renderHeight;
  final double renderWidth;
  const _Avatar({required this.renderHeight, required this.renderWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: renderHeight,
      width: renderWidth * 0.5,
      padding: EdgeInsets.only(bottom: renderHeight * 0.1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              bottomRight: Radius.circular(90))),
      child: Image.asset(
        "assets/images/forgot_password.png",
        fit: BoxFit.contain,
        height: renderHeight * 0.65,
        width: renderWidth * 25,
      ),
    );
  }
}
