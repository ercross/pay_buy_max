import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style_sheet.dart';
import 'horizontal_bar.dart';

class AuthenticationTextField extends StatelessWidget {
  final String fieldName;
  final IconData leading;
  final bool isPassword;
  final void Function(String?) onSaved;
  final double renderHeight;
  final double renderWidth;
  final bool isDigits;
  final bool excludeFieldName;

  const AuthenticationTextField(
      {required this.fieldName,
      required this.leading,
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
                        onSaved: (input) {
                          if (input != null) onSaved(input.trim());
                        },
                        keyboardType: isDigits ? TextInputType.number : null,
                        style: StyleSheet.black14w500,
                        decoration: InputDecoration(
                            hintText: "Enter your ${fieldName.toLowerCase()}",
                            hintStyle: StyleSheet.grey14w400,
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
                  onSaved: onSaved,
                  keyboardType: isDigits ? TextInputType.number : null,
                  style: StyleSheet.black14w500,
                  decoration: InputDecoration(
                      hintText: "Enter your ${fieldName.toLowerCase()}",
                      hintStyle: StyleSheet.grey14w400,
                      border: InputBorder.none,
                      icon: Icon(leading, color: Colors.grey)),
                )));
  }
}

class PasswordAuthField extends StatefulWidget {
  final double height;
  final double width;
  final Function(String) onSaved;

  PasswordAuthField(
      {required this.onSaved, required this.height, required this.width});

  @override
  _PasswordAuthFieldState createState() => _PasswordAuthFieldState();
}

class _PasswordAuthFieldState extends State<PasswordAuthField> {
  bool _obscureText = true;
  late FocusNode _focusNode;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: kElevationToShadow[1],
        ),
        child: Row(
          children: [
            Expanded(
              child: Platform.isIOS
                  ? CupertinoTextFormFieldRow(
                      toolbarOptions: ToolbarOptions(
                          paste: true, copy: true, cut: true, selectAll: true),
                      onSaved: (input) {
                        if (input != null)
                          widget.onSaved(input.trim());
                        else
                          widget.onSaved(input ?? "");
                      },
                      focusNode: _focusNode,
                      style: StyleSheet.black14w400,
                      keyboardType: TextInputType.text,
                      cursorHeight: widget.height * 0.3,
                      cursorColor: Colors.black87,
                      obscureText: _obscureText,
                      placeholder: "Password (Min 8 characters)",
                      placeholderStyle: StyleSheet.grey14w400,
                      prefix: Icon(Icons.lock, color: Colors.grey),
                      onChanged: (input) {
                        if (input.isNotEmpty)
                          setState(() => _hasText == true);
                        else
                          setState(() => _hasText == true);
                      },
                      onFieldSubmitted: (_) =>
                          setState(() => _focusNode.unfocus()),
                      decoration: BoxDecoration(
                        border: Border(),
                      ),
                    )
                  : TextFormField(
                      toolbarOptions: ToolbarOptions(
                          paste: true, copy: true, cut: true, selectAll: true),
                      onSaved: (input) {
                        if (input != null)
                          widget.onSaved(input.trim());
                        else
                          widget.onSaved(input ?? "");
                      },
                      focusNode: _focusNode,
                      style: StyleSheet.black14w400,
                      keyboardType: TextInputType.text,
                      cursorHeight: widget.height * 0.3,
                      cursorColor: Colors.black87,
                      obscureText: _obscureText,
                      onChanged: (input) {
                        if (input.isNotEmpty)
                          setState(() => _hasText == true);
                        else
                          setState(() => _hasText == true);
                      },
                      onFieldSubmitted: (_) =>
                          setState(() => _focusNode.unfocus()),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.lock, color: Colors.grey),
                          hintText: "Password (Min 8 characters)",
                          contentPadding: EdgeInsets.zero,
                          hintStyle: StyleSheet.grey14w400),
                    ),
            ),
            Visibility(
              visible: _focusNode.hasFocus,
              child: IconButton(
                  splashRadius: null,
                  onPressed: () {
                    _obscureText
                        ? setState(() => _obscureText = false)
                        : setState(() => _obscureText = true);
                  },
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility
                        : Icons.visibility_off_rounded,
                    color: Colors.black,
                  )),
            )
          ],
        ));
  }
}
