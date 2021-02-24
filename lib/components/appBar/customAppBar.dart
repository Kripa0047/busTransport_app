import 'package:busTransport/uitls/metaData.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double barHeight;
  final Color color;
  final bool isBack;

  CustomAppBar({
    Key key,
    this.title,
    this.color,
    this.barHeight = 50.0,
    this.isBack = false,
  })  : preferredSize = Size.fromHeight(barHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: barHeight,
      backgroundColor: color ?? primaryColor,
      elevation: 0,
      titleSpacing: 0,
      leading: isBack
          ? SizedBox()
          : InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
              ),
            ),
    );
  }
}
