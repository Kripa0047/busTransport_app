import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class CustomRaiseButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final EdgeInsets padding;
  final double fontSize;
  final Color color;

  CustomRaiseButton({
    @required this.title,
    @required this.onTap,
    this.padding,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: color ?? primaryColor,
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: primaryTextColor,
          fontSize: fontSize ?? secondaryFontSize,
          fontWeight: primaryFontWeight,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 13,
          ),
      focusElevation: 0,
      elevation: 0,
      hoverElevation: 2,
    );
  }
}
