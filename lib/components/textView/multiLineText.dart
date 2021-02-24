import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class MultiLineText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLine;
  final TextAlign align;
  MultiLineText(
    this.text, {
    Key key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.maxLine,
    this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? primaryTextColor,
        fontWeight: fontWeight ?? primaryFontWeight,
        fontSize: fontSize ?? primaryFontSize,
      ),
      maxLines: maxLine,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
    );
  }
}
