import 'package:flutter/material.dart';

class ColorlessAppBar extends StatelessWidget {
  final double width;
  const ColorlessAppBar({required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(),
    );
  }
}
