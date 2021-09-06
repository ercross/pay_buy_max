import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style_sheet.dart';

class BackButton extends StatelessWidget {
  const BackButton();

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBarBackButton(
            onPressed: () => Navigator.of(context).pop(),
          )
        : IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: StyleSheet.primaryColor),
            iconSize: 26,
          );
  }
}
