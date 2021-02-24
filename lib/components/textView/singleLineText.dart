import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class SingleLineText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  SingleLineText(
    this.text, {
    Key key,
    this.color,
    this.fontWeight,
    this.fontSize,
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
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
