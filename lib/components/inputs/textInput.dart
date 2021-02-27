import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final Function validator;
  final bool enabled;
  final Function onTap;
  final bool obscureText;
  final int maxLines;
  final Function onChange;
  final bool readOnly;
  final String value;

  const TextInput({
    Key key,
    this.controller,
    this.hintText,
    this.title,
    this.validator,
    this.enabled = true,
    this.onTap,
    this.obscureText,
    this.maxLines = 1,
    this.onChange,
    this.readOnly = false,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          initialValue: value,
          onChanged: onChange,
          maxLines: maxLines,
          controller: controller,
          enabled: enabled,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            labelText: title,
            border: InputBorder.none,
            fillColor: Color(0xffededed),
            filled: true,
          ),
          obscureText: obscureText ?? false,
          style: const TextStyle(
            color: primaryColor,
            fontWeight: secondaryFontWeight,
            fontSize: secondaryFontSize,
          ),
        ),
      ),
    );
  }
}
