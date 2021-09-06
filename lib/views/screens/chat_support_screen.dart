import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pay_buy_max/views/screens/landing_screen_scaffold/landing_screen_scaffold.dart';

import '../../style_sheet.dart';

class ChatSupport extends StatelessWidget {
  const ChatSupport();

  static const String route = "/chat-support";

  @override
  Widget build(BuildContext context) {
    late PreferredSizeWidget appBar;
    if (Platform.isIOS)
      appBar = CupertinoNavigationBar(
        backgroundColor: StyleSheet.primaryColor,
        automaticallyImplyLeading: true,
        middle: Text("PayBuyMax Support",
            textAlign: TextAlign.center, style: StyleSheet.white15w500),
      );
    else if (Platform.isAndroid)
      appBar = AppBar(
        backgroundColor: StyleSheet.primaryColor,
        leading: IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(LandingPageScaffold.route),
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white)),
        centerTitle: true,
        title: Text("PayBuyMax Support",
            textAlign: TextAlign.center, style: StyleSheet.white15w500),
      );
    return WebviewScaffold(
      url: "https://tawk.to/chat/611a3e55649e0a0a5cd158cd/1fd7870l0",
      withJavascript: true,
      initialChild: Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: StyleSheet.primaryColor.withOpacity(0.5),
        ),
      ),
      appBar: appBar,
      resizeToAvoidBottomInset: true,
      clearCookies: false,
      clearCache: false,
    );
  }
}
