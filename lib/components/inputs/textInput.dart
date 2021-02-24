import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final Function validator;
  final bool enabled;
  final Function onTap;
  const TextInput({
    Key key,
    this.controller,
    this.hintText,
    this.title,
    this.validator,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: title,
        border: InputBorder.none,
        fillColor: Color(0xffedfcff),
        filled: true,
        
      ),
      style: const TextStyle(
        color: primaryColor,
        fontWeight: secondaryFontWeight,
        fontSize: secondaryFontSize,
      ),
    );
  }
}
