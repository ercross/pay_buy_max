import 'package:flutter/material.dart';

import '../../style_sheet.dart';

/// Avoid setting a color that has opacity < 1
class HorizontalBar extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;

  /// [onPressed] is the function invoked when this widget is clicked.
  final dynamic onPressed;

  const HorizontalBar(
      {required this.height,
      required this.width,
      required this.child,
      this.color = Colors.white})
      : onPressed = null;

  const HorizontalBar.button(
      {required this.child,
      required this.height,
      required this.width,
      required this.onPressed,
      this.color = StyleSheet.primaryColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed != null ? () => onPressed() : null,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        padding: EdgeInsets.all(8),
        child: child,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: kElevationToShadow[1],
          color: color,
        ),
      ),
    );
  }
}
