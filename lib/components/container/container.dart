import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double blurRadius;
  const CustomContainer({
    Key key,
    this.child,
    this.margin,
    this.padding,
    this.blurRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(10),
      padding: padding ?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius ?? 5.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
