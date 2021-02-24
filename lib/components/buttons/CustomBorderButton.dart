import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color textColor;
  final double size;
  final EdgeInsets padding;
  CustomFlatButton({
    @required this.title,
    @required this.onTap,
    this.textColor,
    this.size,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: textColor ?? primaryColor,
          fontSize: size ?? primaryFontSize,
          fontWeight: primaryFontWeight,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      padding: padding ?? EdgeInsets.symmetric(vertical: 13, horizontal: 10),
    );
  }
}
