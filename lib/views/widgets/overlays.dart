import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../style_sheet.dart';

class AppOverlay {
  static void snackbar({String title = "", required String message}) {
    Get.snackbar(title, message,
        margin: EdgeInsets.only(bottom: 40, right: 20, left: 20),
        titleText: Text(
          title,
          textAlign: TextAlign.center,
          style: StyleSheet.black14w400,
        ),
        messageText: Text(
          message,
          textAlign: TextAlign.center,
          style: StyleSheet.black13w300,
        ),
        snackPosition: SnackPosition.BOTTOM);
  }
}
