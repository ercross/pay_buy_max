import 'package:flutter/material.dart';

import '../../style_sheet.dart';
import 'horizontal_bar.dart';

class AuthenticationTextField extends StatelessWidget {
  final String fieldName;
  final IconData leading;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String?) onSaved;
  final double renderHeight;
  final double renderWidth;
  final bool isDigits;
  final bool excludeFieldName;

  const AuthenticationTextField(
      {required this.fieldName,
      required this.leading,
      required this.validator,
      required this.onSaved,
      required this.renderHeight,
      required this.renderWidth,
      this.excludeFieldName = false,
      this.isDigits = false,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: renderHeight,
        width: renderWidth,
        child: !excludeFieldName
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!excludeFieldName)
                    Text(fieldName, style: StyleSheet.black16w400),
                  HorizontalBar(
                      height: renderHeight * 0.6,
                      width: renderWidth,
                      child: TextFormField(
                        obscureText: isPassword,
                        validator: validator,
                        onSaved: onSaved,
                        keyboardType: isDigits ? TextInputType.number : null,
                        style: StyleSheet.black14w500,
                        decoration: InputDecoration(
                            hintText: "Enter your ${fieldName.toLowerCase()}",
                            hintStyle: StyleSheet.grey14w500,
                            border: InputBorder.none,
                            icon: Icon(leading, color: Colors.grey)),
                      ))
                ],
              )
            : HorizontalBar(
                height: renderHeight,
                width: renderWidth,
                child: TextFormField(
                  obscureText: isPassword,
                  validator: validator,
                  onSaved: onSaved,
                  keyboardType: isDigits ? TextInputType.number : null,
                  style: StyleSheet.black14w500,
                  decoration: InputDecoration(
                      hintText: "Enter your ${fieldName.toLowerCase()}",
                      hintStyle: StyleSheet.grey14w500,
                      border: InputBorder.none,
                      icon: Icon(leading, color: Colors.grey)),
                )));
  }
}
